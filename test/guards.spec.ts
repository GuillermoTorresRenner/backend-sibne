import { Test, TestingModule } from '@nestjs/testing';
import { ExecutionContext } from '@nestjs/common';
import { AuthGuard } from '../src/auth/guards/auth.guard';
import { RoleGuard } from '../src/auth/guards/role.guard';
import { UsuariosService } from '../src/usuarios/usuarios.service';
import { JwtService } from '@nestjs/jwt';
import { Reflector } from '@nestjs/core';

describe('Guards', () => {
  let authGuard: AuthGuard;
  let roleGuard: RoleGuard;
  let usuariosService: jest.Mocked<UsuariosService>;
  let jwtService: jest.Mocked<JwtService>;
  let reflector: jest.Mocked<Reflector>;

  const mockUsuariosService = {
    findOne: jest.fn(),
    getUserRoles: jest.fn(),
  };

  const mockJwtService = {
    verifyAsync: jest.fn(),
  };

  const mockReflector = {
    getAllAndOverride: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthGuard,
        RoleGuard,
        { provide: UsuariosService, useValue: mockUsuariosService },
        { provide: JwtService, useValue: mockJwtService },
        { provide: Reflector, useValue: mockReflector },
      ],
    }).compile();

    authGuard = module.get<AuthGuard>(AuthGuard);
    roleGuard = module.get<RoleGuard>(RoleGuard);
    usuariosService = module.get(UsuariosService);
    jwtService = module.get(JwtService);
    reflector = module.get(Reflector);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('AuthGuard', () => {
    const createMockExecutionContext = (
      headers: any = {},
      cookies: any = {},
    ): ExecutionContext =>
      ({
        switchToHttp: () => ({
          getRequest: () => ({
            headers,
            cookies,
          }),
        }),
      }) as ExecutionContext;

    it('should allow access with valid Bearer token', async () => {
      const mockRequest = {
        headers: { authorization: 'Bearer valid-token' },
        cookies: {},
      };

      const context = {
        switchToHttp: () => ({
          getRequest: () => mockRequest,
        }),
      } as ExecutionContext;

      const mockUsuario = {
        id: 'test-user-id',
        userName: 'testuser',
        habilitado: true,
      };

      mockJwtService.verifyAsync.mockResolvedValue({ id: 'test-user-id' });
      mockUsuariosService.findOne.mockResolvedValue(mockUsuario);
      mockUsuariosService.getUserRoles.mockResolvedValue(['USER']);

      const result = await authGuard.canActivate(context);

      expect(result).toBe(true);
      expect(mockRequest['userID']).toBe('test-user-id');
      expect(mockRequest['usuario']).toEqual(mockUsuario);
      expect(mockRequest['roles']).toEqual(['USER']);
    });

    it('should allow access with valid cookie token', async () => {
      const mockRequest = {
        headers: {},
        cookies: { token: 'valid-cookie-token' },
      };

      const context = {
        switchToHttp: () => ({
          getRequest: () => mockRequest,
        }),
      } as ExecutionContext;

      const mockUsuario = {
        id: 'test-user-id',
        userName: 'testuser',
        habilitado: true,
      };

      mockJwtService.verifyAsync.mockResolvedValue({ id: 'test-user-id' });
      mockUsuariosService.findOne.mockResolvedValue(mockUsuario);
      mockUsuariosService.getUserRoles.mockResolvedValue(['USER']);

      const result = await authGuard.canActivate(context);

      expect(result).toBe(true);
    });

    it('should deny access without token', async () => {
      const context = createMockExecutionContext();

      await expect(authGuard.canActivate(context)).rejects.toThrow(
        'Token no encontrado',
      );
    });

    it('should deny access with invalid token', async () => {
      const context = createMockExecutionContext({
        authorization: 'Bearer invalid-token',
      });

      mockJwtService.verifyAsync.mockRejectedValue(new Error('Invalid token'));

      await expect(authGuard.canActivate(context)).rejects.toThrow(
        'Token inválido',
      );
    });

    it('should deny access for disabled user', async () => {
      const mockRequest = {
        headers: { authorization: 'Bearer valid-token' },
        cookies: {},
      };

      const context = {
        switchToHttp: () => ({
          getRequest: () => mockRequest,
        }),
      } as ExecutionContext;

      const disabledUsuario = {
        id: 'test-user-id',
        userName: 'testuser',
        habilitado: false,
      };

      mockJwtService.verifyAsync.mockResolvedValue({ id: 'test-user-id' });
      mockUsuariosService.findOne.mockResolvedValue(disabledUsuario);

      await expect(authGuard.canActivate(context)).rejects.toThrow(
        'Usuario deshabilitado',
      );
    });
  });

  describe('RoleGuard', () => {
    const createMockExecutionContext = (
      roles: string[] = [],
    ): ExecutionContext =>
      ({
        switchToHttp: () => ({
          getRequest: () => ({
            roles,
          }),
        }),
        getHandler: jest.fn(),
        getClass: jest.fn(),
      }) as any;

    it('should allow access when no roles are required', async () => {
      const context = createMockExecutionContext(['USER']);

      mockReflector.getAllAndOverride.mockReturnValue(null);

      const result = await roleGuard.canActivate(context);

      expect(result).toBe(true);
    });

    it('should allow access when user has required role', async () => {
      const context = createMockExecutionContext(['USER', 'ADMIN']);

      mockReflector.getAllAndOverride.mockReturnValue(['ADMIN']);

      const result = await roleGuard.canActivate(context);

      expect(result).toBe(true);
    });

    it('should allow access when user has one of multiple required roles', async () => {
      const context = createMockExecutionContext(['USER']);

      mockReflector.getAllAndOverride.mockReturnValue(['ADMIN', 'USER']);

      const result = await roleGuard.canActivate(context);

      expect(result).toBe(true);
    });

    it('should deny access when user lacks required role', async () => {
      const context = createMockExecutionContext(['USER']);

      mockReflector.getAllAndOverride.mockReturnValue(['ADMIN']);

      await expect(roleGuard.canActivate(context)).rejects.toThrow(
        'No tienes permisos para acceder a este recurso',
      );
    });

    it('should deny access when user has no roles', async () => {
      const context = createMockExecutionContext([]);

      mockReflector.getAllAndOverride.mockReturnValue(['USER']);

      await expect(roleGuard.canActivate(context)).rejects.toThrow(
        'No tienes permisos para acceder a este recurso',
      );
    });
  });
});
