# 🏢 SIBNE Backend

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

**Sistema de Información del Balance Nacional de Energía** - API Backend desarrollada con NestJS, Prisma ORM y PostgreSQL, implementando autenticación JWT con sistema de roles para la gestión de información energética empresarial.

## 🚀 Tecnologías Principales

- **NestJS** v11.1.6 - Framework Node.js progresivo
- **Prisma ORM** v6.16.2 - ORM moderno para PostgreSQL
- **PostgreSQL** - Base de datos relacional
- **JWT** - Autenticación con tokens
- **bcrypt** - Encriptación de contraseñas
- **TypeScript** - Tipado estático

## 📁 Estructura del Proyecto

```
src/
├── auth/                     # Sistema de autenticación
│   ├── decorators/          # @Auth, @ActiveUser, @Role
│   ├── guards/              # AuthGuard, RoleGuard
│   ├── dto/                 # DTOs de login/registro
│   ├── roles.enum.ts        # Enum de roles (AuthRoles)
│   └── auth.service.ts      # Lógica de autenticación
├── usuarios/                # Gestión de usuarios
├── prisma/                  # Servicio Prisma
├── test/                    # Controlador de pruebas
└── utils/                   # Utilidades

prisma/schema/               # Schemas divididos por dominio
├── Usuario.prisma
├── Role.prisma
├── UsuarioRole.prisma
├── Empresa.prisma
└── ...
```

## 🔐 Sistema de Roles y Autenticación

### Roles Disponibles

```typescript
export enum AuthRoles {
  ADMINISTRADOR = 'Administrador',
  USUARIO = 'Usuario',
  USUARIO_EMPRESA = 'Usuario Empresa',
}
```

### Uso de Decoradores

```typescript
import { Auth } from '../auth/decorators/auth.decorator';
import { AuthRoles } from '../auth/roles.enum';
import { ActiveUser } from '../auth/decorators/activeUser.decorator';

@Controller('ejemplo')
export class EjemploController {
  // Solo administradores
  @Get('admin-only')
  @Auth([AuthRoles.ADMINISTRADOR])
  adminOnly(@ActiveUser() user) {
    return { message: 'Solo administradores' };
  }

  // Múltiples roles
  @Get('multi-role')
  @Auth([AuthRoles.USUARIO, AuthRoles.ADMINISTRADOR])
  multiRole(@ActiveUser() user) {
    return { message: 'Usuarios o administradores' };
  }

  // Solo autenticación (sin roles específicos)
  @Get('protected')
  @UseGuards(AuthGuard)
  protected(@ActiveUser() user) {
    return { message: 'Usuario autenticado', user };
  }
}
```

## 🔑 Credenciales de Prueba

```typescript
/**
 * ADMINISTRADOR:
 * - username: pvd
 * - password: BNE_MENDPEDS2024
 *
 * USUARIO:
 * - username: [pendiente]
 * - password: [pendiente]
 *
 * USUARIO EMPRESA:
 * - username: 00327
 * - password: jo091
 */
```

## 📋 API Endpoints

### Autenticación

- `POST /api/auth/login` - Iniciar sesión
- `POST /api/auth/logout` - Cerrar sesión
- `GET /api/auth/me` - Obtener perfil del usuario

### Endpoints de Prueba

- `GET /api/test/public` - Endpoint público
- `GET /api/test/protected` - Requiere autenticación
- `GET /api/test/admin-only` - Solo administradores
- `GET /api/test/empresa-only` - Solo usuarios empresa
- `GET /api/test/user-or-admin` - Usuarios o administradores

## 🛠️ Comandos de Desarrollo

### Instalación e Inicio

```bash
# Instalar dependencias de Node.js
npm install

# Instalar dependencias globales (si es necesario)
npm install -g @nestjs/cli prisma

# Modo desarrollo con hot reload
npm run start:dev

# Modo debug
npm run start:debug

# Modo producción
npm run start:prod

# Compilar proyecto
npm run build

# Formatear código
npm run format

# Linting y corrección automática
npm run lint
```

### Base de Datos y Prisma

```bash
# Generar cliente Prisma (después de cambios en schema)
npx prisma generate

# Ejecutar migraciones en desarrollo
npx prisma migrate dev --name <nombre_migracion>

# Resetear base de datos (¡CUIDADO! Borra todos los datos)
npx prisma migrate reset

# Ver estado de migraciones
npx prisma migrate status

# Abrir Prisma Studio (interfaz gráfica para ver/editar datos)
npx prisma studio

```

### Gestión de Base de Datos (Scripts Personalizados)

```bash
# Crear backup de la base de datos
npm run db:backup

# Restaurar backup de la base de datos
npm run db:restore

# Listar backups disponibles
npm run db:list-backups
```

### Gestión de Contraseñas (Scripts Personalizados)

```bash
# Encriptar contraseñas existentes en la base de datos
npm run passwords:encrypt

# Verificar contraseñas encriptadas (solo verificación)
npm run passwords:check
```

### Testing

```bash
# Tests unitarios
npm run test

# Tests unitarios en modo watch (se ejecutan automáticamente al cambiar archivos)
npm run test:watch

# Tests end-to-end (e2e)
npm run test:e2e

# Tests con coverage (reporte de cobertura)
npm run test:cov

# Tests en modo debug
npm run test:debug

# Tests de stress con Artillery
npm run test:stress

# Tests de stress con reporte HTML
npm run test:stress:report
```

### 🔥 Tests de Stress

El proyecto incluye tests de stress automatizados con **Artillery v2.0.26**:

```bash
# Ejecutar tests de stress (requiere aplicación corriendo)
npm run test:stress

# Generar reporte HTML detallado
npm run test:stress:report

# Ver reporte generado
open artillery-report.html
```

**Características de los tests:**

- **⏱️ Duración optimizada**: 3 minutos total (180 segundos)
- **4 fases** de carga: warmup (30s), normal (60s), stress (60s), peak (30s)
- **4 escenarios** diferentes: público, auth, roles, mixto
- **Métricas completas**: latencia, throughput, errores
- **Reportes HTML**: Dashboards interactivos descargables
- **CI/CD integrado**: Ejecutión automática en GitHub Actions

### 🚀 Comandos de Inicio Rápido

```bash
# Setup completo del proyecto (primera vez)
npm install && npx prisma generate && npx prisma migrate dev

# Iniciar desarrollo completo
npm run start:dev & npx prisma studio

# Resetear y poblar base de datos
npx prisma migrate reset && npm run seed

# Verificar estado del proyecto
npm run build && npm run test
```

## 📚 Documentación API

- **Swagger UI**: `http://localhost:3000/api/docs`
- **Postman Collection**: Disponible en `/docs`

## 🔒 Seguridad

- **JWT Tokens**: Autenticación stateless con expiración configurable
- **bcrypt**: Hash seguro de contraseñas con salt rounds
- **Role Guards**: Control granular de acceso por roles
- **Input Validation**: Validación de DTOs con class-validator
- **CORS**: Configuración de políticas de origen cruzado

## 🐳 Docker

### Desarrollo Local

```bash
# Levantar base de datos PostgreSQL
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener servicios
docker-compose down
```

### Construcción de Imagen

```bash
# Construir imagen local
docker build -t sibne-backend:latest .

# Construir con etiqueta específica
docker build -t sibne-backend:v1.0.0 .

# Construir para múltiples plataformas
docker buildx build --platform linux/amd64,linux/arm64 -t sibne-backend:latest .
```

### Ejecución con Docker

```bash
# Ejecutar contenedor con variables de entorno
docker run -d \
  --name sibne-backend \
  --env-file .env \
  -p 3000:3000 \
  sibne-backend:latest

# Ejecutar con PostgreSQL en red
docker network create sibne-network
docker run -d --name postgres --network sibne-network postgres:15
docker run -d --name backend --network sibne-network -p 3000:3000 sibne-backend:latest
```

### CI/CD con GitHub Actions

El proyecto incluye un workflow completo que:

- ✅ Ejecuta tests unitarios y e2e
- ✅ Construye la imagen Docker optimizada
- ✅ Sube a DockerHub con etiquetas `latest` y `commit-sha`
- ✅ Realiza escaneo de seguridad con Trivy
- ✅ Soporte para múltiples arquitecturas (amd64, arm64)

## ⚙️ Variables de Entorno

Crear archivo `.env` basado en `.env.example`:

```env
DATABASE_URL="postgresql://usuario:password@localhost:5432/sibne_db"
JWT_SECRET="tu_jwt_secret_aqui"
JWT_EXPIRES_IN="1h"
PORT=3000
```

## 🧪 Testing

El proyecto incluye pruebas completas:

- **Unit Tests**: Servicios y controladores individuales
- **E2E Tests**: Flujos completos de autenticación y roles
- **Integration Tests**: Interacciones con base de datos
- **API Tests**: Validación de endpoints con curl

Ver `TESTING_SUMMARY.md` para detalles completos.

## 📧 Contacto

- **Proyecto**: SIBNE (Sistema de Información del Balance Nacional de Energía)
- **Repository**: backend-sibne
- **Autor**: Guillermo Torres Renner
- **Email**: soporte@tchile.com

## 🚀 Estado del Proyecto

- ✅ **Sistema de Autenticación**: Completo con JWT y roles
- ✅ **Base de Datos**: Configurada con Prisma y PostgreSQL
- ✅ **Testing**: Suite completa de pruebas implementada
- ✅ **Documentación**: Swagger UI y guías completas
- 🔄 **En Desarrollo**: Módulos específicos del dominio energético

## 🏗️ Próximos Pasos

- [ ] Implementar módulos de gestión energética
- [ ] Dashboard de métricas y reportes
- [ ] Integración con APIs externas
- [ ] Optimización de performance
- [ ] Deploy a producción

## 📚 Recursos Adicionales

- [NestJS Documentation](https://docs.nestjs.com) - Framework documentation
- [Prisma Documentation](https://www.prisma.io/docs) - ORM documentation
- [PostgreSQL Documentation](https://www.postgresql.org/docs/) - Database documentation
- [JWT.io](https://jwt.io/) - JSON Web Token information

---
# Cambios efectivos realizados en el modelo de la base de datos.
## Eliminaciones de tablas:
1. Eliminación de la tabla **CargaMasivaArchivo**
2. Eliminación de la tabla **CargaMasivaDetalle**
3. Eliminación de la tabla **CargaMasivaError**
4. Eliminación de la tabla **Usuario**
5. Eliminación de la tabla **UsuarioRole**
6. Eliminación de la tabla **UsuarioToken**
7. Eliminación de la tabla **EstadoReportes**
7. Eliminación de la tabla **Reportes**

## Modificaciones en tablas existentes:
1. Reestructuración de las relaciones entre las tablas:
  - **Comuna**
  - **Provincia**
  - **Region**
2. Se agrega el campo password a la tabla de **Contacto** y se relaciona con la tabla **Role** y **EmailLog**.
3. Se cambia el nombre de la tabla **UsuarioLogin** a **ContactoLogin**. Se relaciona con la tabla **Contacto** y el Enum **LoginProviders**.
4. Se elimina la relación de **EmailConfig** y **EmailLogs**. Se relaciona esta tabla con la tabla **ListaEmpresasEmail**. También se elimina la relación con **EstadoEmail**.
5. **EmailLogs**
  - **Eliminación de campos:** Se eliminaron los campos `fechaHoraRegistro`, `estado`, `para`, `msje` y `empresaId`.  
    _Comentario:_ Estos datos ya no serán almacenados en la tabla. Si necesitas conservarlos, deberás migrarlos a otra estructura o descartarlos.
  - **Eliminación de relación con Empresa:** Se eliminó la relación directa con la tabla **Empresa** (`empresaId` y el campo relacional `empresa`).  
    _Comentario:_ Ahora los logs de email no están ligados directamente a una empresa, sino a un contacto.
  - **Adición de relación con Contacto:** Se agregó la relación con la tabla **Contacto** mediante el campo `contactoId` y el objeto relacional `contacto`.  
    _Comentario:_ Cada log de email puede estar asociado a un contacto específico, permitiendo trazabilidad a nivel de usuario/contacto.
  - **Adición de relación con EstadoEmail:** Se agregó la relación con la tabla **EstadoEmail** mediante el campo `estadoEmailId` y el objeto relacional `estadoEmail`.  
    _Comentario:_ El estado del email ahora se gestiona mediante una tabla relacional, permitiendo mayor flexibilidad y normalización de los estados posibles.
  - **Eliminación de campos de mensaje y destinatario:** Se eliminaron los campos `para` (destinatario) y `msje` (mensaje).  
    _Comentario:_ Si estos datos son necesarios, deben migrarse a otra tabla o estructura antes de aplicar la migración.
  - **Renombramiento y simplificación de campos de fecha:** Se eliminó `fechaHoraRegistro` y se mantuvo solo `fechaHoraEnvio`.  
    _Comentario:_ Solo se conserva la fecha de envío del email, simplificando la trazabilidad temporal.



## Creaciones de tablas nuevas:
1. Se crea el Enum **LoginProviders** para la tabla **ContactoLogin**. 
2. Se crea la tabla **ListaEmpresasEmail** para relacionar las empresas con las configuraciones de email.