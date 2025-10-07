import { PartialType } from '@nestjs/swagger';
import { CreateUsuarioDto } from './create-usuario.dto';
import { IsNotEmpty, IsString } from 'class-validator';

export class LoginUsuario extends PartialType(CreateUsuarioDto) {
  @IsString()
  @IsNotEmpty()
  userName: string;
  @IsString()
  @IsNotEmpty()
  passwordHash: string;
}
