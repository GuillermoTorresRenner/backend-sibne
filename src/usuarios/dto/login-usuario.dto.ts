import { IsNotEmpty, IsString } from 'class-validator';

export class LoginUsuario {
  @IsString()
  @IsNotEmpty()
  userName: string; // Puede ser userName o email

  @IsString()
  @IsNotEmpty()
  passwordHash: string; // Password en texto plano, se hashea en el servicio
}
