import { PrismaService } from '../src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

export class TestDataHelper {
  constructor(private prismaService: PrismaService) {}

  /**
   * Crear usuarios y roles de prueba
   */
  async setupTestData() {
    // Crear roles
    const usuarioRole = await this.prismaService.role.upsert({
      where: { id: 'usuario-role-test' },
      update: {},
      create: {
        id: 'usuario-role-test',
        name: 'USUARIO',
        normalizedName: 'USUARIO',
        concurrencyStamp: 'test-stamp-usuario',
      },
    });

    const adminRole = await this.prismaService.role.upsert({
      where: { id: 'admin-role-test' },
      update: {},
      create: {
        id: 'admin-role-test',
        name: 'ADMINISTRADOR',
        normalizedName: 'ADMINISTRADOR',
        concurrencyStamp: 'test-stamp-admin',
      },
    });

    const empresaRole = await this.prismaService.role.upsert({
      where: { id: 'empresa-role-test' },
      update: {},
      create: {
        id: 'empresa-role-test',
        name: 'USUARIO EMPRESA',
        normalizedName: 'USUARIO EMPRESA',
        concurrencyStamp: 'test-stamp-empresa',
      },
    });

    // Crear usuarios
    const hashedPassword = bcrypt.hashSync('testpassword123', 10);

    const testUser = await this.prismaService.usuario.upsert({
      where: { id: 'test-user-id' },
      update: {},
      create: {
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

    const adminUser = await this.prismaService.usuario.upsert({
      where: { id: 'test-admin-id' },
      update: {},
      create: {
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
    await this.prismaService.usuarioRole.upsert({
      where: {
        userId_roleId: {
          userId: testUser.id,
          roleId: usuarioRole.id,
        },
      },
      update: {},
      create: {
        userId: testUser.id,
        roleId: usuarioRole.id,
      },
    });

    await this.prismaService.usuarioRole.upsert({
      where: {
        userId_roleId: {
          userId: adminUser.id,
          roleId: adminRole.id,
        },
      },
      update: {},
      create: {
        userId: adminUser.id,
        roleId: adminRole.id,
      },
    });

    return {
      users: { testUser, adminUser },
      roles: { usuarioRole, adminRole, empresaRole },
    };
  }

  /**
   * Limpiar datos de prueba
   */
  async cleanupTestData() {
    try {
      // Eliminar relaciones usuario-rol
      await this.prismaService.usuarioRole.deleteMany({
        where: {
          userId: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar tokens
      await this.prismaService.usuarioToken.deleteMany({
        where: {
          userId: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar usuarios
      await this.prismaService.usuario.deleteMany({
        where: {
          id: {
            in: ['test-user-id', 'test-admin-id'],
          },
        },
      });

      // Eliminar roles
      await this.prismaService.role.deleteMany({
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

  /**
   * Obtener credenciales de prueba
   */
  getTestCredentials() {
    return {
      user: {
        userName: 'testuser',
        passwordHash: 'testpassword123',
        id: 'test-user-id',
      },
      admin: {
        userName: 'testadmin',
        passwordHash: 'testpassword123',
        id: 'test-admin-id',
      },
    };
  }

  /**
   * Generar token JWT de prueba con datos del usuario
   */
  async generateTestToken(jwtService: any, userId: string, roles: string[]) {
    const payload = {
      id: userId,
      userName: userId === 'test-user-id' ? 'testuser' : 'testadmin',
      email:
        userId === 'test-user-id' ? 'test@example.com' : 'admin@example.com',
      roles: roles,
    };

    return await jwtService.signAsync(payload, { expiresIn: '1h' });
  }
}
