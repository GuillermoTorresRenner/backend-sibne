import { Module } from '@nestjs/common';

import { PrismaService } from './prisma/prisma.service';
import { AuthModule } from './auth/auth.module';
import { PrismaModule } from './prisma/prisma.module';
import { MulterModule } from '@nestjs/platform-express';
import { UsuariosModule } from './usuarios/usuarios.module';
import { RolesModule } from './roles/roles.module';
import { TestModule } from './test/test.module';

@Module({
  imports: [
    AuthModule,
    PrismaModule,
    MulterModule.register({
      dest: './uploads',
    }),
    UsuariosModule,
    RolesModule,
    TestModule,
  ],
  controllers: [],
  providers: [PrismaService],
})
export class AppModule {}
