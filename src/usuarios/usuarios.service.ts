import {
  Injectable,
  NotFoundException,
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUsuarioDto } from './dto/create-usuario.dto';
import { UpdateUsuarioDto } from './dto/update-usuario.dto';
import { LoginDto } from '../auth/dto/login.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsuariosService {
  constructor(private prismaService: PrismaService) {}

  async create(createUsuarioDto: CreateUsuarioDto) {
    try {
      const usuarioExists = await this.findByEmail(createUsuarioDto.email);
      if (usuarioExists) throw new BadRequestException('El usuario ya existe');

      const hashedPassword = bcrypt.hashSync(createUsuarioDto.passwordHash, 10);

      const usuario = await this.prismaService.usuario.create({
        data: {
          ...createUsuarioDto,
          passwordHash: hashedPassword,
          emailConfirmed: false,
          phoneNumberConfirmed: false,
          twoFactorEnabled: false,
          lockoutEnabled: true,
          accessFailedCount: 0,
          habilitado: true,
          eliminado: false,
          primerIngreso: true,
        },
        include: {
          usuarioRoles: {
            include: {
              role: true,
            },
          },
        },
      });
      return usuario;
    } catch (error) {
      throw new InternalServerErrorException({
        message: 'Error al crear usuario',
        error,
      });
    }
  }

  async findAll() {
    return await this.prismaService.usuario.findMany({
      where: { eliminado: false },
      include: {
        usuarioRoles: {
          include: {
            role: true,
          },
        },
      },
    });
  }

  async findOne(id: string) {
    const usuario = await this.prismaService.usuario.findUnique({
      where: { id },
      include: {
        usuarioRoles: {
          include: {
            role: true,
          },
        },
      },
    });
    if (!usuario) throw new NotFoundException('Usuario no encontrado');
    return usuario;
  }

  async findByEmail(email: string) {
    return await this.prismaService.usuario.findFirst({
      where: {
        email,
        eliminado: false,
      },
      include: {
        usuarioRoles: {
          include: {
            role: true,
          },
        },
      },
    });
  }

  async findByUserName(userName: string) {
    return await this.prismaService.usuario.findFirst({
      where: {
        userName,
        eliminado: false,
      },
      include: {
        usuarioRoles: {
          include: {
            role: true,
          },
        },
      },
    });
  }

  async validateCredentials(loginDto: LoginDto) {
    // Buscar por userName o email
    const usuario =
      (await this.findByUserName(loginDto.userName)) ||
      (await this.findByEmail(loginDto.userName));

    if (!usuario || !usuario.habilitado) {
      throw new NotFoundException('Usuario o contraseña incorrectos');
    }

    const isValidPassword = await bcrypt.compare(
      loginDto.password,
      usuario.passwordHash,
    );
    if (!isValidPassword) {
      throw new NotFoundException('Usuario o contraseña incorrectos');
    }

    return usuario;
  }

  async update(id: string, updateUsuarioDto: UpdateUsuarioDto) {
    const usuario = await this.findOne(id);

    const updateData: any = { ...updateUsuarioDto };

    // Si se actualiza la password, hashearla
    if (updateUsuarioDto.passwordHash) {
      updateData.passwordHash = bcrypt.hashSync(
        updateUsuarioDto.passwordHash,
        10,
      );
    }

    return await this.prismaService.usuario.update({
      where: { id },
      data: updateData,
      include: {
        usuarioRoles: {
          include: {
            role: true,
          },
        },
      },
    });
  }

  async remove(id: string) {
    // Soft delete
    return await this.prismaService.usuario.update({
      where: { id },
      data: { eliminado: true },
    });
  }

  async updateRefreshToken(id: string, refreshToken: string | null) {
    if (!refreshToken) {
      // Eliminar refresh token
      await this.prismaService.usuarioToken.deleteMany({
        where: {
          userId: id,
          loginProvider: 'SIBNE',
          name: 'RefreshToken',
        },
      });
      return;
    }

    // Guardar en UsuarioToken
    await this.prismaService.usuarioToken.upsert({
      where: {
        userId_loginProvider_name: {
          userId: id,
          loginProvider: 'SIBNE',
          name: 'RefreshToken',
        },
      },
      update: {
        value: refreshToken,
      },
      create: {
        userId: id,
        loginProvider: 'SIBNE',
        name: 'RefreshToken',
        value: refreshToken,
      },
    });
  }

  async getRefreshToken(id: string): Promise<string | null> {
    const token = await this.prismaService.usuarioToken.findUnique({
      where: {
        userId_loginProvider_name: {
          userId: id,
          loginProvider: 'SIBNE',
          name: 'RefreshToken',
        },
      },
    });
    return token?.value || null;
  }

  async getUserRoles(id: string): Promise<string[]> {
    const usuario = await this.findOne(id);
    return usuario.usuarioRoles.map((ur) => ur.role.name).filter(Boolean);
  }

  async assignRole(userId: string, roleId: string) {
    return await this.prismaService.usuarioRole.create({
      data: {
        userId,
        roleId,
      },
    });
  }

  async removeRole(userId: string, roleId: string) {
    return await this.prismaService.usuarioRole.delete({
      where: {
        userId_roleId: {
          userId,
          roleId,
        },
      },
    });
  }
}
