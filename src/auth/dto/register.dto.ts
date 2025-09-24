import { UserRole } from '@prisma/client';
import { IsEmail, IsString, MinLength, IsEnum } from 'class-validator';

export class RegisterDto {
  @IsEmail()
  email: string;
  @MinLength(8)
  @IsString()
  password: string;
  @IsString()
  @MinLength(3)
  name: string;
  @IsString()
  @MinLength(3)
  surname: string;
  @IsEnum(UserRole)
  role: UserRole;
}
