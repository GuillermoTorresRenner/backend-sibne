import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { RolesModule } from '../roles/roles.module';
import { ContactosModule } from '../contactos/contactos.module';

@Module({
  imports: [AuthModule, RolesModule, ContactosModule],
  // controllers: [],
})
export class TestModule {}
