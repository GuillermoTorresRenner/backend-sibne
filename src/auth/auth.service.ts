import {
  BadRequestException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { UsuariosService } from '../usuarios/usuarios.service';
import { LoginUsuario } from '../usuarios/dto/login-usuario.dto';
import { JwtService } from '@nestjs/jwt';
import { CreateUsuarioDto } from '../usuarios/dto/create-usuario.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly usuariosService: UsuariosService,
    private readonly jwtService: JwtService,
  ) {}

  async login(loginDto: LoginUsuario) {
    const usuario = await this.usuariosService.validateCredentials(loginDto);

    // Obtener roles del usuario
    const roles = await this.usuariosService.getUserRoles(usuario.id);

    // Generar access token (5 min) y refresh token (24h)
    const payload = {
      id: usuario.id,
      userName: usuario.userName,
      email: usuario.email,
      roles: roles,
    };

    const accessToken = await this.jwtService.signAsync(payload, {
      expiresIn: '5m',
    });
    const refreshToken = await this.jwtService.signAsync(
      { id: usuario.id },
      { expiresIn: '24h' },
    );

    // Guardar refresh token en la base de datos
    await this.usuariosService.updateRefreshToken(usuario.id, refreshToken);

    return {
      accessToken,
      refreshToken,
      usuario: {
        id: usuario.id,
        userName: usuario.userName,
        email: usuario.email,
        nombre: usuario.nombre,
        apellido: usuario.apellido,
        roles: roles,
      },
    };
  }

  async register(createUsuarioDto: CreateUsuarioDto) {
    const usuario = await this.usuariosService.create(createUsuarioDto);
    const roles = await this.usuariosService.getUserRoles(usuario.id);

    return {
      id: usuario.id,
      userName: usuario.userName,
      email: usuario.email,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      roles: roles,
    };
  }

  async refresh(userId: string, refreshToken: string) {
    const usuario = await this.usuariosService.findOne(userId);
    if (!usuario) throw new UnauthorizedException('No autorizado');

    const storedRefreshToken =
      await this.usuariosService.getRefreshToken(userId);
    if (!storedRefreshToken || storedRefreshToken !== refreshToken) {
      throw new UnauthorizedException('Refresh token inválido');
    }

    // Validar refresh token
    try {
      await this.jwtService.verifyAsync(refreshToken);
    } catch {
      throw new UnauthorizedException('Refresh token expirado o inválido');
    }

    // Obtener roles actualizados
    const roles = await this.usuariosService.getUserRoles(usuario.id);

    // Generar nuevos tokens
    const payload = {
      id: usuario.id,
      userName: usuario.userName,
      email: usuario.email,
      roles: roles,
    };

    const newAccessToken = await this.jwtService.signAsync(payload, {
      expiresIn: '5m',
    });
    const newRefreshToken = await this.jwtService.signAsync(
      { id: usuario.id },
      { expiresIn: '24h' },
    );

    await this.usuariosService.updateRefreshToken(usuario.id, newRefreshToken);
    return {
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
      usuario: {
        id: usuario.id,
        userName: usuario.userName,
        email: usuario.email,
        nombre: usuario.nombre,
        apellido: usuario.apellido,
        roles: roles,
      },
    };
  }
}
