
import { IsNotEmpty, IsEnum, IsInt } from 'class-validator';
import { $Enums } from '@prisma/client';

export class CreateContactoLoginDto {
  @IsNotEmpty()
  @IsEnum($Enums.LoginProviders)
  loginProvider: $Enums.LoginProviders;

  @IsNotEmpty()
  @IsInt()
  contactoId: number;
}