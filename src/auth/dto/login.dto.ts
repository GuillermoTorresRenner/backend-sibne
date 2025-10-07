import { IsString, MinLength } from 'class-validator';

export class LoginDto {
  @IsString()
  userName: string; // Puede ser userName o email

  @IsString()
  @MinLength(8)
  passwordHash: string;
}
