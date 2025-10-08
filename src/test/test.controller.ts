import { Controller, Get, UseGuards } from '@nestjs/common';
import { AuthGuard } from '../auth/guards/auth.guard';
import { RoleGuard } from '../auth/guards/role.guard';
import { Role } from '../auth/decorators/roles.decorator';
import { ActiveUser } from '../auth/decorators/activeUser.decorator';
import { Auth } from '../auth/decorators/auth.decorator';
import { AuthRoles } from '../auth/roles.enum';
/**
 * ADMINISTRADOR:
 * - username: pvd
 * - password: BNE_MENDPEDS2024
 * USUARIO:
 * - username:
 * - password:
 * USUARIO EMPRESA:
 * - username: 00327
 * - password: jo091
 */
@Controller('test')
export class TestController {
  @Get('public')
  public() {
    return { message: 'Este endpoint es público' };
  }

  @Get('protected')
  @UseGuards(AuthGuard)
  protected(@ActiveUser() user) {
    return {
      message: 'Este endpoint requiere autenticación',
      user: user,
    };
  }

  @Get('admin-only')
  @Auth([AuthRoles.ADMINISTRADOR])
  adminOnly(@ActiveUser() user) {
    return {
      message: 'Solo administradores pueden acceder',
      user: user,
    };
  }
  @Get('usuario-only')
  @Auth([AuthRoles.USUARIO])
  usuarioEmpresaOnly(@ActiveUser() user) {
    return {
      message: 'Solo usuarios pueden acceder',
      user: user,
    };
  }

  @Get('user-or-admin')
  @Auth([AuthRoles.USUARIO, AuthRoles.ADMINISTRADOR])
  userOrAdmin(@ActiveUser() user) {
    return {
      message: 'Usuarios o administradores pueden acceder',
      user: user,
    };
  }

  @Get('empresa-only')
  @Auth([AuthRoles.USUARIO_EMPRESA])
  empresaOnly(@ActiveUser() user) {
    return {
      message: 'Solo usuarios empresa pueden acceder',
      user: user,
    };
  }

  @Get('empresa-or-admin')
  @Auth([AuthRoles.USUARIO_EMPRESA, AuthRoles.ADMINISTRADOR])
  empresaOrAdmin(@ActiveUser() user) {
    return {
      message: 'Usuarios empresa o administradores pueden acceder',
      user: user,
    };
  }
}
