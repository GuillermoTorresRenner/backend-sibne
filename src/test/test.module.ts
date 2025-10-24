import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { RolesModule } from '../roles/roles.module';
import { ContactosModule } from '../contactos/contactos.module';

import { TestController } from './test.controller';

@Module({
  imports: [AuthModule, RolesModule, ContactosModule],
  controllers: [TestController],
})
export class TestModule {}
