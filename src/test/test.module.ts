import { Module } from '@nestjs/common';
import { TestController } from './test.controller';
import { AuthModule } from '../auth/auth.module';
import { UsuariosModule } from '../usuarios/usuarios.module';
import { RolesModule } from '../roles/roles.module';

@Module({
  imports: [AuthModule, UsuariosModule, RolesModule],
  controllers: [TestController],
})
export class TestModule {}
