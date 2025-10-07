import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { UsuariosService } from './usuarios.service';
import { CreateUsuarioDto } from './dto/create-usuario.dto';
import { UpdateUsuarioDto } from './dto/update-usuario.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { RoleGuard } from '../auth/guards/role.guard';
import { Role } from '../auth/decorators/roles.decorator';

@Controller('usuarios')
@UseGuards(AuthGuard, RoleGuard)
export class UsuariosController {
  constructor(private readonly usuariosService: UsuariosService) {}

  @Post()
  @Role(['ADMIN'])
  create(@Body() createUsuarioDto: CreateUsuarioDto) {
    return this.usuariosService.create(createUsuarioDto);
  }

  @Get()
  @Role(['ADMIN'])
  findAll() {
    return this.usuariosService.findAll();
  }

  @Get(':id')
  @Role(['ADMIN'])
  findOne(@Param('id') id: string) {
    return this.usuariosService.findOne(id);
  }

  @Patch(':id')
  @Role(['ADMIN'])
  update(@Param('id') id: string, @Body() updateUsuarioDto: UpdateUsuarioDto) {
    return this.usuariosService.update(id, updateUsuarioDto);
  }

  @Delete(':id')
  @Role(['ADMIN'])
  remove(@Param('id') id: string) {
    return this.usuariosService.remove(id);
  }

  @Post(':userId/roles/:roleId')
  @Role(['ADMIN'])
  assignRole(@Param('userId') userId: string, @Param('roleId') roleId: string) {
    return this.usuariosService.assignRole(userId, roleId);
  }

  @Delete(':userId/roles/:roleId')
  @Role(['ADMIN'])
  removeRole(@Param('userId') userId: string, @Param('roleId') roleId: string) {
    return this.usuariosService.removeRole(userId, roleId);
  }
}
