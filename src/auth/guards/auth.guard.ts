import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request } from 'express';
import { UsuariosService } from '../../usuarios/usuarios.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private readonly usuariosService: UsuariosService,
    private readonly jwtService: JwtService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<Request>();
    const token =
      this.extractTokenFromHeader(request) ||
      this.extractTokenFromCookies(request);

    if (!token) {
      throw new UnauthorizedException('Token no encontrado');
    }

    try {
      const payload = await this.jwtService.verifyAsync(token, {
        secret: process.env.JWT_SECRET,
      });

      const usuario = await this.usuariosService.findOne(payload.id);
      if (!usuario || !usuario.habilitado) {
        throw new UnauthorizedException('Usuario no autorizado');
      }

      const roles = await this.usuariosService.getUserRoles(payload.id);

      request['userID'] = payload.id;
      request['usuario'] = usuario;
      request['roles'] = roles;
    } catch (error) {
      throw new UnauthorizedException('Token inválido');
    }
    return true;
  }

  private extractTokenFromHeader(request: Request): string | null {
    const [type, token] = request.headers.authorization?.split(' ') ?? [];
    return type === 'Bearer' ? token : null;
  }

  private extractTokenFromCookies(request: Request): string | null {
    return request.cookies?.['token'] || null;
  }
}
