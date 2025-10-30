import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { ContactosService } from '../contactos/contactos.service';
import { LoginDto } from './dto/login.dto';
import { JwtService } from '@nestjs/jwt';
import { ContactoLoginService } from '../contacto-login/contacto-login.service';
import { $Enums } from '@prisma/client';

@Injectable()
export class AuthService {
  constructor(
    private readonly contactosService: ContactosService,
    private readonly jwtService: JwtService,
    private readonly contactoLoginService: ContactoLoginService,
  ) {}

  async login(loginDto: LoginDto) {

    // Ahora loginDto debe tener email y password
    const contacto = await this.contactosService.validateCredentials(
      loginDto.email,
      loginDto.password,
    );

    // Registrar login exitoso
    await this.contactoLoginService.newLogin({
      loginProvider: $Enums.LoginProviders.EMAIL_Y_PASSWORD,
      contactoId: contacto.id,
    });

    // Obtener el rol del contacto (solo uno)
    const role = contacto.roleId || null;

    // Generar access token (5 min) y refresh token (24h)
    const payload = {
      id: contacto.id,
      email: contacto.email,
      role: role,
    };

    const accessToken = await this.jwtService.signAsync(payload, {
      expiresIn: '5m',
    });
    const refreshToken = await this.jwtService.signAsync(
      { id: contacto.id },
      { expiresIn: '24h' },
    );

    // Aquí deberías guardar el refresh token en la base de datos si lo deseas

    return {
      accessToken,
      refreshToken,
      usuario: {
        id: contacto.id,
        email: contacto.email,
        nombre: contacto.nombre,
        cargo: contacto.cargo,
        telefono: contacto.telefono,
        roleId: contacto.roleId,
        role: role,
      },
    };
  }

  // El registro de contacto se haría en ContactosService, no aquí

  async refresh(userId: number, refreshToken: string) {
    // Aquí deberías buscar el contacto y validar el refresh token si lo guardas
    const contacto = await this.contactosService.findOne(userId);
    if (!contacto) throw new UnauthorizedException('No autorizado');

    // Validar refresh token (si lo guardas en la base de datos)
    // ...

    // Generar nuevos tokens
    const role = contacto.roleId || null;
    const payload = {
      id: contacto.id,
      email: contacto.email,
      role: role,
    };

    const newAccessToken = await this.jwtService.signAsync(payload, {
      expiresIn: '5m',
    });
    const newRefreshToken = await this.jwtService.signAsync(
      { id: contacto.id },
      { expiresIn: '24h' },
    );

    // Aquí deberías actualizar el refresh token en la base de datos si lo guardas

    return {
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
      usuario: {
        id: contacto.id,
        email: contacto.email,
        nombre: contacto.nombre,
        cargo: contacto.cargo,
        telefono: contacto.telefono,
        roleId: contacto.roleId,
        role: role,
      },
    };
  }

//=======================AUTH CLAVEUNICA=======================//


}
