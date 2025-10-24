import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { ContactosModule } from '../contactos/contactos.module';
import { RolesModule } from '../roles/roles.module';
import { JwtModule } from '@nestjs/jwt';
import { AuthGuard } from './guards/auth.guard';
import { RoleGuard } from './guards/role.guard';
import { ContactoLoginModule } from '../contacto-login/contacto-login.module';
import { ContactoLoginService } from '../contacto-login/contacto-login.service';

@Module({
  imports: [
    ContactosModule,
    RolesModule,
    ContactoLoginModule,
    JwtModule.register({
      global: true,
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: '1d' },
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, AuthGuard, RoleGuard, ContactoLoginService],
  exports: [AuthService, AuthGuard, RoleGuard],
})
export class AuthModule {}
