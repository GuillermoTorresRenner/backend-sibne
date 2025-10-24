import { Prisma } from "@prisma/client";

export class Contacto implements Prisma.ContactoCreateInput {
    nombre: string;
    cargo: string;
    email: string;
    telefono: string;
    rut: number;
    digitoVerificador: string;
    password?: string;
    createdAt?: string | Date;
    updatedAt?: string | Date;
    empresa: Prisma.EmpresaCreateNestedOneWithoutContactosInput;
    tipoContacto: Prisma.TipoContactoCreateNestedOneWithoutContactosInput;
    role?: Prisma.RoleCreateNestedOneWithoutContactosInput;
    contactoLogins?: Prisma.ContactoLoginCreateNestedManyWithoutContactosInput;
    emailLogs?: Prisma.EmailLogsCreateNestedManyWithoutContactoInput;
}
