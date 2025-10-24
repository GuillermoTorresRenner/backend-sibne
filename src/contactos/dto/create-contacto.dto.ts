import { IsString, IsNotEmpty, IsEmail,  IsNumber, MinLength,  Min, Max } from 'class-validator';

export class CreateContactoDto {
	@IsString()
	@IsNotEmpty()
	nombre: string;

	@IsString()
	@IsNotEmpty()
	cargo: string;

	@IsEmail()
	@IsNotEmpty()
	email: string;

	@IsString()
	@IsNotEmpty()
	telefono: string;

	@IsNumber()
    @IsNotEmpty()
    @Min(1000000)
    @Max(99999999)
	rut: number;

	@IsString()
	@IsNotEmpty()
	digitoVerificador: string;

	@IsString()
	@MinLength(8)
	password: string;

	@IsString()
	@IsNotEmpty()
	empresaId: string;

	@IsNumber()
	tipoContactoId: number;

	@IsString()
	roleId?: string;
}
