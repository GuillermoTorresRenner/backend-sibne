import { Module } from '@nestjs/common';
import { ContactoLoginService } from './contacto-login.service';

@Module({
  providers: [ContactoLoginService],
  exports: [ContactoLoginService],
})
export class ContactoLoginModule {}
