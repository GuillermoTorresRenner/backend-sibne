# 🔐 Guía de Roles y Autenticación - SIBNE Backend

## 📋 Roles Disponibles en el Sistema

Los roles definidos en la base de datos son:

```typescript
'ADMINISTRADOR'    // Administrador del sistema
'USUARIO'          // Usuario básico
'USUARIO EMPRESA'  // Usuario de empresa
```

## 🛡️ Decoradores de Autenticación

### 1. `@Auth(['ROLE'])` - Decorador Completo
Combina autenticación y control de roles en uno solo:

```typescript
import { Auth } from '../auth/decorators/auth.decorator';

@Controller('productos')
export class ProductosController {
  
  // Solo administradores
  @Get('admin-panel')
  @Auth(['ADMINISTRADOR'])
  getAdminPanel() {
    return { message: 'Panel de administración' };
  }
  
  // Usuarios básicos o administradores
  @Get('mis-productos')
  @Auth(['USUARIO', 'ADMINISTRADOR'])
  getMisProductos(@ActiveUser() user) {
    return this.productosService.findByUser(user.userID);
  }
  
  // Solo usuarios empresa
  @Get('empresa-dashboard')
  @Auth(['USUARIO EMPRESA'])
  getEmpresaDashboard(@ActiveUser() user) {
    return this.empresaService.getDashboard(user.userID);
  }
  
  // Solo logueado (cualquier rol)
  @Get('perfil')
  @Auth()
  getPerfil(@ActiveUser() user) {
    return { usuario: user.usuario, roles: user.roles };
  }
}
```

### 2. `@UseGuards()` + `@Role()` - Control Granular
Para mayor control sobre la autenticación:

```typescript
import { UseGuards } from '@nestjs/common';
import { AuthGuard } from '../auth/guards/auth.guard';
import { RoleGuard } from '../auth/guards/role.guard';
import { Role } from '../auth/decorators/roles.decorator';

@Controller('reportes')
export class ReportesController {
  
  @Get('financieros')
  @UseGuards(AuthGuard, RoleGuard)
  @Role(['ADMINISTRADOR', 'USUARIO EMPRESA'])
  getReportesFinancieros(@ActiveUser() user) {
    return this.reportesService.getFinancieros(user.userID);
  }
  
  @Get('publicos')
  @UseGuards(AuthGuard) // Solo requiere login
  getReportesPublicos() {
    return this.reportesService.getPublicos();
  }
}
```

### 3. `@ActiveUser()` - Obtener Datos del Usuario
Accede a la información del usuario autenticado:

```typescript
@Get('mi-perfil')
@Auth(['USUARIO', 'ADMINISTRADOR', 'USUARIO EMPRESA'])
getMiPerfil(@ActiveUser() user) {
  // user contiene:
  // - userID: string
  // - usuario: { id, userName, email, nombre, apellido, ... }
  // - roles: string[] (ej: ['USUARIO'], ['ADMINISTRADOR'])
  
  return {
    id: user.userID,
    username: user.usuario.userName,
    email: user.usuario.email,
    nombre: user.usuario.nombre,
    apellido: user.usuario.apellido,
    roles: user.roles,
    esAdmin: user.roles.includes('ADMINISTRADOR'),
    esEmpresa: user.roles.includes('USUARIO EMPRESA')
  };
}
```

## 🎯 Ejemplos Prácticos por Tipo de Usuario

### Para Administradores
```typescript
@Controller('admin')
export class AdminController {
  
  @Get('usuarios')
  @Auth(['ADMINISTRADOR'])
  getAllUsuarios() {
    return this.usuariosService.findAll();
  }
  
  @Post('crear-empresa')
  @Auth(['ADMINISTRADOR'])
  crearEmpresa(@Body() empresaData, @ActiveUser() admin) {
    return this.empresasService.create(empresaData, admin.userID);
  }
  
  @Delete('usuario/:id')
  @Auth(['ADMINISTRADOR'])
  eliminarUsuario(@Param('id') id: string, @ActiveUser() admin) {
    return this.usuariosService.softDelete(id, admin.userID);
  }
}
```

### Para Usuarios Empresa
```typescript
@Controller('empresa')
export class EmpresaController {
  
  @Get('mi-empresa')
  @Auth(['USUARIO EMPRESA'])
  getMiEmpresa(@ActiveUser() user) {
    return this.empresasService.findByUserId(user.userID);
  }
  
  @Post('reportes')
  @Auth(['USUARIO EMPRESA', 'ADMINISTRADOR'])
  crearReporte(@Body() reporteData, @ActiveUser() user) {
    return this.reportesService.create(reporteData, user.userID);
  }
  
  @Get('empleados')
  @Auth(['USUARIO EMPRESA'])
  getEmpleados(@ActiveUser() user) {
    return this.empleadosService.findByEmpresa(user.userID);
  }
}
```

### Para Usuarios Básicos
```typescript
@Controller('usuario')
export class UsuarioController {
  
  @Get('perfil')
  @Auth(['USUARIO', 'ADMINISTRADOR', 'USUARIO EMPRESA'])
  getPerfil(@ActiveUser() user) {
    return this.usuariosService.getProfile(user.userID);
  }
  
  @Put('actualizar-perfil')
  @Auth(['USUARIO'])
  actualizarPerfil(@Body() updateData, @ActiveUser() user) {
    return this.usuariosService.updateProfile(user.userID, updateData);
  }
  
  @Get('configuracion')
  @Auth(['USUARIO'])
  getConfiguracion(@ActiveUser() user) {
    return this.configService.getUserConfig(user.userID);
  }
}
```

## 🔄 Aplicar a Nivel de Controlador
También puedes aplicar guards a todo un controlador:

```typescript
@Controller('admin')
@UseGuards(AuthGuard, RoleGuard)
@Role(['ADMINISTRADOR']) // Todos los endpoints requieren ser ADMINISTRADOR
export class AdminController {
  
  @Get('dashboard')
  // Hereda la protección del controlador
  getDashboard() {
    return this.adminService.getDashboard();
  }
  
  @Get('reportes')
  // También protegido automáticamente
  getReportes() {
    return this.reportesService.getAll();
  }
  
  @Get('super-admin-only')
  @Role(['SUPER_ADMIN']) // Sobreescribe el rol del controlador
  getSuperAdminData() {
    return this.adminService.getSuperAdminData();
  }
}
```

## 🧪 Endpoints de Prueba Disponibles

Ya tienes endpoints de prueba configurados en `/api/test/`:

```bash
# Público - sin autenticación
GET /api/test/public

# Protegido - solo login requerido
GET /api/test/protected

# Solo administradores
GET /api/test/admin-only

# Usuarios o administradores
GET /api/test/user-or-admin

# Solo usuarios empresa
GET /api/test/empresa-only

# Usuarios empresa o administradores
GET /api/test/empresa-or-admin
```

## ⚠️ Importante

1. **Usa los nombres exactos**: `'ADMINISTRADOR'`, `'USUARIO'`, `'USUARIO EMPRESA'`
2. **Para múltiples roles**: usa arrays `['USUARIO', 'ADMINISTRADOR']`
3. **Espacios en roles**: el rol `'USUARIO EMPRESA'` tiene espacio, úsalo tal como está
4. **Orden de guards**: siempre `@UseGuards(AuthGuard, RoleGuard)` en ese orden
5. **ActiveUser**: solo funciona en endpoints protegidos con `AuthGuard`

¡Tu sistema de roles está completamente actualizado y listo para usar! 🚀