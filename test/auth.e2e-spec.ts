import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { PrismaService } from '../src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

describe('Authentication E2E', () => {
  let app: INestApplication;
  let prismaService: PrismaService;
  let testUser: any;
  let adminUser: any;
  let accessToken: string;
  let adminAccessToken: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    prismaService = moduleFixture.get<PrismaService>(PrismaService);

    // Configurar el prefijo de la API si existe
    app.setGlobalPrefix('api');

    await app.init();

    // Crear usuarios de prueba
    await setupTestUsers();
  });

  afterAll(async () => {
    // Limpiar usuarios de prueba
    await cleanupTestUsers();
    await prismaService.$disconnect();
    await app.close();
  });

  async function setupTestUsers() {
    // Buscar o crear roles
    let userRole = await prismaService.role.findFirst({
      where: { name: 'USER' },
    });

    if (!userRole) {
      userRole = await prismaService.role.create({
        data: {
          id: 'user-role-test',
          name: 'USER',
          normalizedName: 'USER',
          concurrencyStamp: 'test-stamp-user',
        },
      });
    }

    let adminRole = await prismaService.role.findFirst({
      where: { name: 'ADMIN' },
    });

    if (!adminRole) {
      adminRole = await prismaService.role.create({
        data: {
          id: 'admin-role-test',
          name: 'ADMIN',
          normalizedName: 'ADMIN',
          concurrencyStamp: 'test-stamp-admin',
        },
      });
    }

    // Crear usuario normal
    const hashedPassword = bcrypt.hashSync('testpassword123', 10);

    testUser = await prismaService.usuario.create({
      data: {
        id: 'test-user-id',
        userName: 'testuser',
        email: 'test@example.com',
        passwordHash: hashedPassword,
        nombre: 'Test',
        apellido: 'User',
        emailConfirmed: true,
        phoneNumberConfirmed: false,
        twoFactorEnabled: false,
        lockoutEnabled: false,
        accessFailedCount: 0,
        habilitado: true,
        eliminado: false,
        primerIngreso: false,
      },
    });

    // Crear usuario admin
    adminUser = await prismaService.usuario.create({
      data: {
        id: 'test-admin-id',
        userName: 'testadmin',
        email: 'admin@example.com',
        passwordHash: hashedPassword,
        nombre: 'Test',
        apellido: 'Admin',
        emailConfirmed: true,
        phoneNumberConfirmed: false,
        twoFactorEnabled: false,
        lockoutEnabled: false,
        accessFailedCount: 0,
        habilitado: true,
        eliminado: false,
        primerIngreso: false,
      },
    });

    // Asignar roles
    await prismaService.usuarioRole.create({
      data: {
        userId: testUser.id,
        roleId: userRole.id,
      },
    });

    await prismaService.usuarioRole.create({
      data: {
        userId: adminUser.id,
        roleId: adminRole.id,
      },
    });
  }

  async function cleanupTestUsers() {
    try {
      // Eliminar relaciones usuario-rol
      await prismaService.usuarioRole.deleteMany({
        where: {
          userId: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar tokens
      await prismaService.usuarioToken.deleteMany({
        where: {
          userId: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar usuarios
      await prismaService.usuario.deleteMany({
        where: {
          id: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar roles de prueba
      await prismaService.role.deleteMany({
        where: {
          id: {
            in: ['user-role-test', 'admin-role-test'],
          },
        },
      });
    } catch (error) {
      console.log('Error cleaning up test data:', error);
    }
  }

  describe('POST /auth/login', () => {
    it('should login with valid credentials', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/auth/login')
        .send({
          userName: 'testuser',
          passwordHash: 'testpassword123',
        })
        .expect(200);

      expect(response.body).toHaveProperty('accessToken');
      expect(response.body).toHaveProperty('usuario');
      expect(response.body.usuario.userName).toBe('testuser');
      expect(response.body.usuario.roles).toContain('USER');

      accessToken = response.body.accessToken;
    });

    it('should login admin user', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/auth/login')
        .send({
          userName: 'testadmin',
          passwordHash: 'testpassword123',
        })
        .expect(200);

      expect(response.body).toHaveProperty('accessToken');
      expect(response.body.usuario.roles).toContain('ADMIN');

      adminAccessToken = response.body.accessToken;
    });

    it('should reject invalid credentials', async () => {
      await request(app.getHttpServer())
        .post('/api/auth/login')
        .send({
          userName: 'testuser',
          passwordHash: 'wrongpassword',
        })
        .expect(404);
    });

    it('should reject non-existent user', async () => {
      await request(app.getHttpServer())
        .post('/api/auth/login')
        .send({
          userName: 'nonexistent',
          passwordHash: 'testpassword123',
        })
        .expect(404);
    });
  });

  describe('GET /auth/me', () => {
    it('should return user info with valid token', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/auth/me')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body.userName).toBe('testuser');
      expect(response.body.roles).toContain('USER');
    });

    it('should reject request without token', async () => {
      await request(app.getHttpServer()).get('/api/auth/me').expect(401);
    });

    it('should reject request with invalid token', async () => {
      await request(app.getHttpServer())
        .get('/api/auth/me')
        .set('Authorization', 'Bearer invalid-token')
        .expect(401);
    });
  });

  describe('POST /auth/logout', () => {
    it('should logout successfully', async () => {
      await request(app.getHttpServer())
        .post('/api/auth/logout')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);
    });
  });

  describe('Public Endpoints', () => {
    it('should access public endpoint without authentication', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/test/public')
        .expect(200);

      expect(response.body.message).toBe('Este endpoint es público');
    });
  });

  describe('Protected Endpoints', () => {
    it('should access protected endpoint with valid token', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/test/protected')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body.message).toBe(
        'Este endpoint requiere autenticación',
      );
      expect(response.body.user).toBeDefined();
      expect(response.body.user.userID).toBe('test-user-id');
    });

    it('should reject protected endpoint without token', async () => {
      await request(app.getHttpServer()).get('/api/test/protected').expect(401);
    });
  });

  describe('Role-based Endpoints', () => {
    it('should allow admin access to admin-only endpoint', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/test/admin-only')
        .set('Authorization', `Bearer ${adminAccessToken}`)
        .expect(200);

      expect(response.body.message).toBe('Solo administradores pueden acceder');
      expect(response.body.user.roles).toContain('ADMIN');
    });

    it('should reject user access to admin-only endpoint', async () => {
      await request(app.getHttpServer())
        .get('/api/test/admin-only')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(401);
    });

    it('should allow both user and admin to user-or-admin endpoint', async () => {
      // Test con usuario normal
      const userResponse = await request(app.getHttpServer())
        .get('/api/test/user-or-admin')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(userResponse.body.message).toBe(
        'Usuarios o administradores pueden acceder',
      );

      // Test con admin
      const adminResponse = await request(app.getHttpServer())
        .get('/api/test/user-or-admin')
        .set('Authorization', `Bearer ${adminAccessToken}`)
        .expect(200);

      expect(adminResponse.body.message).toBe(
        'Usuarios o administradores pueden acceder',
      );
    });
  });

  describe('ActiveUser Decorator', () => {
    it('should provide user data through ActiveUser decorator', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/test/protected')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body.user).toBeDefined();
      expect(response.body.user.userID).toBe('test-user-id');
      expect(response.body.user.usuario).toBeDefined();
      expect(response.body.user.roles).toContain('USER');
    });

    it('should provide admin data through ActiveUser decorator', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/test/admin-only')
        .set('Authorization', `Bearer ${adminAccessToken}`)
        .expect(200);

      expect(response.body.user).toBeDefined();
      expect(response.body.user.userID).toBe('test-admin-id');
      expect(response.body.user.roles).toContain('ADMIN');
    });
  });

  describe('CRUD Operations with Role Protection', () => {
    it('should allow admin to access usuarios endpoints', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/usuarios')
        .set('Authorization', `Bearer ${adminAccessToken}`)
        .expect(200);

      expect(Array.isArray(response.body)).toBe(true);
    });

    it('should reject user access to usuarios endpoints', async () => {
      await request(app.getHttpServer())
        .get('/api/usuarios')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(401);
    });
  });
});
