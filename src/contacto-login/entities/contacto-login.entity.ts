import { $Enums, Prisma } from "@prisma/client";

export class ContactoLogin implements Prisma.ContactoLoginCreateInput{
    id?: string;
    loginProvider: $Enums.LoginProviders;
    contactos: Prisma.ContactoCreateNestedOneWithoutContactoLoginsInput;
}
