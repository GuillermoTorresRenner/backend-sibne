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

El proyecto incluye tests de stress automatizados con **Artillery v1.7.9**:

```bash
# Ejecutar tests de stress (requiere aplicación corriendo)
npm run test:stress

# Generar reporte HTML detallado
npm run test:stress:report

# Ver reporte generado
open artillery-report.html
```

**Características de los tests:**
- **5 fases** de carga: warmup, normal, stress, peak, cooldown
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
