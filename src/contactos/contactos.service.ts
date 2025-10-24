import { Injectable, UnauthorizedException, NotFoundException } from '@nestjs/common';
import { CreateContactoDto } from './dto/create-contacto.dto';
import { UpdateContactoDto } from './dto/update-contacto.dto';
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

@Injectable()
export class ContactosService {
  private prisma = new PrismaClient();

  async create(createContactoDto: CreateContactoDto) {
    // Hashear la contraseña si viene en el DTO
    let passwordHash = undefined;
    if (createContactoDto.password) {
      passwordHash = await bcrypt.hash(createContactoDto.password, 10);
    }
    const contacto = await this.prisma.contacto.create({
      data: {
        ...createContactoDto,
        password: passwordHash,
      },
    });
    return contacto;
  }

  findAll() {
    return `This action returns all contactos`;
  }

  async findOne(id: number, withRole = false) {
    const contacto = await this.prisma.contacto.findUnique({
      where: { id },
      include: withRole ? { role: true } : undefined,
    });
    if (!contacto) throw new NotFoundException('Contacto no encontrado');
    return contacto;
  }

  update(id: number, updateContactoDto: UpdateContactoDto) {
    return `This action updates a #${id} contacto`;
  }

  remove(id: number) {
    return `This action removes a #${id} contacto`;
  }

  async findByEmail(email: string) {
    const contacto = await this.prisma.contacto.findFirst({ where: { email } });
    if (!contacto) throw new NotFoundException('Contacto no encontrado');
    return contacto;
  }

  async validateCredentials(email: string, password: string) {
    const contacto = await this.findByEmail(email);
    if (!contacto.password) throw new NotFoundException('Sin contraseña registrada');
    const isMatch = await bcrypt.compare(password, contacto.password);
    if (!isMatch) throw new UnauthorizedException('Credenciales inválidas');
    return contacto;
  }
}
