import { IsEmail, IsNotEmpty, IsString, Length } from 'class-validator';

export class CreateUsuarioDto {
  @IsString()
  @Length(3, 10)
  @IsNotEmpty()
  userName: string;

  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @Length(4, 20)
  @IsNotEmpty()
  password: string;

  @IsString()
  @Length(2, 100)
  @IsNotEmpty()
  nombre: string;

  @IsString()
  @Length(2, 100)
  @IsNotEmpty()
  apellido: string;

  @IsString()
  @IsNotEmpty()
  roleId: string;
}
