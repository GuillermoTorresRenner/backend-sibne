import { Prisma } from '@prisma/client';

export class Usuario implements Prisma.UsuarioCreateInput {
  id: string;
  userName?: string;
  normalizedUserName?: string;
  email?: string;
  normalizedEmail?: string;
  emailConfirmed: boolean;
  passwordHash?: string;
  securityStamp?: string;
  concurrencyStamp?: string;
  phoneNumber?: string;
  phoneNumberConfirmed: boolean;
  twoFactorEnabled: boolean;
  lockoutEnd?: string | Date;
  lockoutEnabled: boolean;
  accessFailedCount: number;
  habilitado: boolean;
  nombre?: string;
  apellido?: string;
  eliminado: boolean;
  primerIngreso: boolean;
  usuarioRoles?: Prisma.UsuarioRoleCreateNestedManyWithoutUsuarioInput;
  logins?: Prisma.UsuarioLoginCreateNestedManyWithoutUsuarioInput;
  tokens?: Prisma.UsuarioTokenCreateNestedManyWithoutUsuarioInput;
}
