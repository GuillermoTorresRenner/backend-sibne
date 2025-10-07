import { AuthGuard } from './auth.guard';
import { JwtService } from '@nestjs/jwt';
import { UsuariosService } from '../../usuarios/usuarios.service';
import { UnauthorizedException } from '@nestjs/common';

describe('AuthGuard', () => {
  let guard: AuthGuard;
  let usuariosService: any;
  let jwtService: any;

  beforeEach(() => {
    usuariosService = {
      findOne: jest.fn(),
      getUserRoles: jest.fn(),
    };
    jwtService = { verifyAsync: jest.fn() };
    guard = new AuthGuard(usuariosService, jwtService);
  });

  it('should be defined', () => {
    expect(guard).toBeDefined();
  });

  it('should throw if no token', async () => {
    const context: any = {
      switchToHttp: () => ({
        getRequest: () => ({
          cookies: {},
          headers: {},
        }),
      }),
    };
    await expect(guard.canActivate(context)).rejects.toThrow(
      'Token no encontrado',
    );
  });

  it('should throw if token is invalid', async () => {
    const context: any = {
      switchToHttp: () => ({
        getRequest: () => ({
          cookies: { token: 'bad-token' },
          headers: {},
        }),
      }),
    };
    jwtService.verifyAsync.mockRejectedValue(new Error('invalid'));
    await expect(guard.canActivate(context)).rejects.toThrow('Token inválido');
  });

  it('should throw if user not found', async () => {
    const context: any = {
      switchToHttp: () => ({
        getRequest: () => ({
          cookies: { token: 'valid-token' },
          headers: {},
        }),
      }),
    };
    jwtService.verifyAsync.mockResolvedValue({ id: 'test-user-id' });
    usuariosService.findOne.mockResolvedValue(null);

    await expect(guard.canActivate(context)).rejects.toThrow('Token inválido');
  });

  it('should set userID, usuario and roles if valid', async () => {
    const req: any = {
      cookies: { token: 'valid-token' },
      headers: {},
    };
    const context: any = {
      switchToHttp: () => ({ getRequest: () => req }),
    };

    const mockUsuario = {
      id: 'test-user-id',
      userName: 'testuser',
      habilitado: true,
    };

    jwtService.verifyAsync.mockResolvedValue({ id: 'test-user-id' });
    usuariosService.findOne.mockResolvedValue(mockUsuario);
    usuariosService.getUserRoles.mockResolvedValue(['USER']);

    const result = await guard.canActivate(context);

    expect(result).toBe(true);
    expect(req.userID).toBe('test-user-id');
    expect(req.usuario).toEqual(mockUsuario);
    expect(req.roles).toEqual(['USER']);
  });
});
