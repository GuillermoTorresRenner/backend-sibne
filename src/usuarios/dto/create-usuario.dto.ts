import {
  IsEmail,
  IsNotEmpty,
  IsString,
  Length,
  IsOptional,
  IsBoolean,
} from 'class-validator';

export class CreateUsuarioDto {
  @IsString()
  @IsNotEmpty()
  id: string; // ID generado externamente o UUID

  @IsString()
  @Length(3, 50)
  @IsOptional()
  userName?: string;

  @IsEmail()
  @IsOptional()
  email?: string;

  @IsString()
  @Length(4, 100)
  @IsNotEmpty()
  passwordHash: string; // Ya hasheada externamente o se hashea en el servicio

  @IsString()
  @Length(2, 100)
  @IsOptional()
  nombre?: string;

  @IsString()
  @Length(2, 100)
  @IsOptional()
  apellido?: string;

  @IsOptional()
  @IsString()
  phoneNumber?: string;

  @IsOptional()
  @IsBoolean()
  emailConfirmed?: boolean;

  @IsOptional()
  @IsBoolean()
  phoneNumberConfirmed?: boolean;

  @IsOptional()
  @IsBoolean()
  twoFactorEnabled?: boolean;

  @IsOptional()
  @IsBoolean()
  lockoutEnabled?: boolean;

  @IsOptional()
  @IsBoolean()
  habilitado?: boolean;
}
