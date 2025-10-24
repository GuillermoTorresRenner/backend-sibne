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

}
