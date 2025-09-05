import { applyDecorators, UseGuards } from '@nestjs/common';
import { Roles } from '../roles.enum';
import { Role } from './roles.decorator';
import { AuthGuard } from '../guards/auth.guard';
import { RoleGuard } from '../guards/role.guard';

export function Auth(roles?: Roles[]) {
  return applyDecorators(Role(roles), UseGuards(AuthGuard, RoleGuard));
}
