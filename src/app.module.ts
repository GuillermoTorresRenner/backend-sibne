import { Module } from '@nestjs/common';

import { PrismaService } from './prisma/prisma.service';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { MulterModule } from '@nestjs/platform-express';
import { RolesModule } from './roles/roles.module';
import { ContactosModule } from './contactos/contactos.module';
import { TestModule } from './test/test.module';
import { ContactoLoginModule } from './contacto-login/contacto-login.module';

@Module({
  imports: [
    AuthModule,
    PrismaModule,
    MulterModule.register({
      dest: './uploads',
    }),
  RolesModule,
  ContactosModule,
  TestModule,
  ContactoLoginModule,
  ],
  controllers: [],
  providers: [PrismaService],
})
export class AppModule {}
