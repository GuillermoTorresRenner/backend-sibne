import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class RolesService {
  constructor(private prismaService: PrismaService) {}

  async findAll() {
    return await this.prismaService.role.findMany();
  }

  async findOne(id: string) {
    const role = await this.prismaService.role.findUnique({
      where: { id },
      include: {
        usuarioRoles: {
          include: { usuario: true },
        },
      },
    });
    if (!role) throw new NotFoundException('Rol no encontrado');
    return role;
  }

  async findByName(name: string) {
    return await this.prismaService.role.findFirst({
      where: {
        OR: [{ name }, { normalizedName: name.toUpperCase() }],
      },
    });
  }

  async create(name: string) {
    return await this.prismaService.role.create({
      data: {
        id: crypto.randomUUID(),
        name,
        normalizedName: name.toUpperCase(),
        concurrencyStamp: crypto.randomUUID(),
      },
    });
  }
}
