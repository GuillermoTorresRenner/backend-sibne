
import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateContactoLoginDto } from './dto/create-contacto-login.dto';

@Injectable()
export class ContactoLoginService {
  constructor(private readonly prismaService: PrismaService) {}

  async newLogin(data: CreateContactoLoginDto) {
    return this.prismaService.contactoLogin.create({
      data: {
        loginProvider: data.loginProvider,
        contactos: {
          connect: { id: data.contactoId },
        },
      },
    });
  }
}
