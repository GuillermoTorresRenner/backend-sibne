import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request } from 'express';
import { ContactosService } from '../../contactos/contactos.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private readonly contactosService: ContactosService,
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

      const contacto = await this.contactosService.findOne(payload.id);
      if (!contacto) {
        throw new UnauthorizedException('Contacto no autorizado');
      }

  // Adaptar rol: solo uno
  const role = contacto.roleId || null;

  request['userID'] = payload.id;
  request['usuario'] = contacto;
  request['role'] = role;
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
