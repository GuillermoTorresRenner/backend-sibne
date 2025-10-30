import {
  Controller,
  Post,
  Get,
  Body,
  Req,
  Res,
  NotFoundException,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { AuthGuard } from './guards/auth.guard';
import { ApiBearerAuth } from '@nestjs/swagger';
import { ActiveUser } from './decorators/activeUser.decorator';
import { ConfigService } from '@nestjs/config';
import { HttpService } from '@nestjs/axios';
import { lastValueFrom } from 'rxjs';

/**
 * @UseGuards(AuthGuard) - Verificar Login Para verificar que el usuario esté logueado:
 
 *@Role(['ADMIN']) - Control de Roles Para controlar acceso por roles específicos:

 *@Auth(['ROLE']) - Decorador Combinado Un decorador que combina autenticación y roles:

 *@ActiveUser() - Información del Usuario Para acceder a los datos del usuario autenticado:
 */
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly configService: ConfigService,
    private readonly httpService: HttpService,
  ) {}


  @Post('login')
  async login(@Body() loginDto: LoginDto, @Res() res) {
    try {
      const result = await this.authService.login(loginDto);

      res.cookie('token', result.accessToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 5 * 60 * 1000, // 5 minutos
      });

      res.cookie('refreshToken', result.refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 24 * 60 * 60 * 1000, // 24 horas
      });

      return res.status(200).json({
        message: 'Login exitoso',
        usuario: result.usuario,
        accessToken: result.accessToken, // Para uso con Bearer token
      });
    } catch (error) {
      return res.status(401).json({
        message: error.message,
      });
    }
  }
  @Post('refresh')
  async refresh(@Req() req, @Res() res) {
    try {
      const refreshToken = req.cookies['refreshToken'];
      if (!refreshToken) {
        return res.status(401).json({ message: 'No refresh token' });
      }

      // Decodificar el token para obtener el id
      let payload: any;
      try {
        payload = await this.authService['jwtService'].verifyAsync(refreshToken);
      } catch {
        return res.status(401).json({ message: 'Refresh token inválido o expirado' });
      }

      const result = await this.authService.refresh(payload.id, refreshToken);

      res.cookie('token', result.accessToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 5 * 60 * 1000,
      });

      res.cookie('refreshToken', result.refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 24 * 60 * 60 * 1000,
      });

      return res.status(200).json({
        message: 'Token refrescado',
        usuario: result.usuario,
        accessToken: result.accessToken,
      });
    } catch (error) {
      return res.status(500).json({ message: error.message });
    }
  }

@UseGuards(AuthGuard)
@Get('me')
async me(@ActiveUser() user) {
  if (!user || !user.usuario) {
    return { message: 'No autenticado' };
  }
  return {
    id: user.usuario.id,
    nombre: user.usuario.nombre,
    email: user.usuario.email,
    cargo: user.usuario.cargo,
    telefono: user.usuario.telefono,
    role: user.role,  
  };
}

//====================ClaveUnica====================//

  /**
   * Endpoint para iniciar el flujo de autenticación con ClaveÚnica
   * Redirige al usuario al formulario de ClaveÚnica
   */
  @Get('claveunica/init')
  async claveUnicaInit(@Res() res, @Req() req) {
    const clientId = this.configService.get('CLAVEUNICA_CLIENT_ID');
    const redirectUri = encodeURIComponent(this.configService.get('CLAVEUNICA_REDIRECT_URI'));
    const state = Math.random().toString(36).substring(2) + Date.now(); // Token anti-CSRF simple
    // Aquí deberías guardar el state en la sesión/cookie para validación posterior
    req.session = req.session || {};
    req.session.cu_state = state;
    const url = `https://accounts.claveunica.gob.cl/openid/authorize/?client_id=${clientId}&response_type=code&scope=openid run name&redirect_uri=${redirectUri}&state=${state}`;
    return res.redirect(url);
  }

  /**
   * Endpoint de callback para recibir el código de autorización de ClaveÚnica
   */
  @Get('claveunica/callback')
  async claveUnicaCallback(@Req() req, @Res() res) {
    const { code, state } = req.query;
    // Validar el state contra el guardado en sesión/cookie
    if (!code) {
      return res.status(400).json({ message: 'Código de autorización no recibido' });
    }
    if (!req.session || state !== req.session.cu_state) {
      return res.status(400).json({ message: 'State inválido o sesión no encontrada' });
    }
    // Intercambiar el código por el access_token
    const clientId = this.configService.get('CLAVEUNICA_CLIENT_ID');
    const clientSecret = this.configService.get('CLAVEUNICA_CLIENT_SECRET');
    const redirectUri = this.configService.get('CLAVEUNICA_REDIRECT_URI');
    const tokenUrl = 'https://accounts.claveunica.gob.cl/openid/token/';
    const params = new URLSearchParams({
      client_id: clientId,
      client_secret: clientSecret,
      redirect_uri: redirectUri,
      grant_type: 'authorization_code',
      code: code,
      state: state,
    });
    try {
      const tokenResponse = await lastValueFrom(
        this.httpService.post(tokenUrl, params, {
          headers: { 'content-type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        })
      );
      const accessToken = tokenResponse.data.access_token;
      if (!accessToken) {
        return res.status(401).json({ message: 'No se recibió access_token' });
      }
      // Obtener datos del usuario
      const userInfoUrl = 'https://accounts.claveunica.gob.cl/openid/userinfo/';
      const userInfoResponse = await lastValueFrom(
        this.httpService.post(
          userInfoUrl,
          {},
          { headers: { authorization: `Bearer ${accessToken}` } }
        )
      );
      // Aquí puedes mapear los datos recibidos y crear el usuario en tu sistema si es necesario
      return res.status(200).json({ claveUnica: userInfoResponse.data });
    } catch (error) {
      return res.status(500).json({ message: 'Error en autenticación ClaveÚnica', error: error.message });
    }
  }


}
