import {
  Controller,
  Post,
  Get,
  Body,
  Req,
  BadRequestException,
  InternalServerErrorException,
  Res,
  NotFoundException,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { CreateUsuarioDto } from '../usuarios/dto/create-usuario.dto';
import { AuthGuard } from './guards/auth.guard';
import { UsuariosService } from '../usuarios/usuarios.service';
import { ActiveUser } from './decorators/activeUser.decorator';
import { ApiBearerAuth } from '@nestjs/swagger';

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
    private readonly usuariosService: UsuariosService,
  ) {}
  @ApiBearerAuth()
  @Post('register')
  async register(@Body() createUsuarioDto: CreateUsuarioDto) {
    try {
      const isUserRegistered = await this.usuariosService.findByEmail(
        createUsuarioDto.email,
      );
      if (isUserRegistered) {
        throw new BadRequestException('Usuario ya registrado');
      }
      const newUser = await this.authService.register(createUsuarioDto);
      return { message: 'Usuario registrado exitosamente', usuario: newUser };
    } catch (error) {
      throw new InternalServerErrorException(
        'Error al registrar usuario',
        error.message,
      );
    }
  }

  @Post('login')
  async login(@Body() loginDto: LoginDto, @Req() req, @Res() res) {
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
        payload =
          await this.authService['jwtService'].verifyAsync(refreshToken);
      } catch {
        return res
          .status(401)
          .json({ message: 'Refresh token inválido o expirado' });
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

  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @Get('me')
  async me(@Req() req, @Res() res) {
    try {
      const usuario = await this.usuariosService.findOne(req.userID);
      const roles = await this.usuariosService.getUserRoles(req.userID);

      if (!usuario) {
        return res.clearCookie('token').json({ message: 'logout' });
      }

      return res.json({
        id: usuario.id,
        userName: usuario.userName,
        email: usuario.email,
        nombre: usuario.nombre,
        apellido: usuario.apellido,
        roles: roles,
      });
    } catch (error) {
      throw new NotFoundException({ message: 'Usuario no encontrado', error });
    }
  }

  @Post('logout')
  @UseGuards(AuthGuard)
  async logout(@Req() req, @Res() res) {
    try {
      // Opcional: Invalidar el refresh token en la base de datos
      await this.usuariosService.updateRefreshToken(req.userID, null);

      res.clearCookie('token');
      res.clearCookie('refreshToken');
      return res.json({ message: 'Sesión cerrada exitosamente' });
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error al cerrar sesión',
        error,
      });
    }
  }
}
