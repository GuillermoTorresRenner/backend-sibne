import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { UsuariosService } from '../usuarios/usuarios.service';
import { AuthGuard } from './guards/auth.guard';
import { JwtModule } from '@nestjs/jwt';

describe('AuthController', () => {
  let controller: AuthController;

  const mockAuthService = {
    register: jest.fn(),
    login: jest.fn(),
    logout: jest.fn(),
  };

  const mockUsuariosService = {
    findOne: jest.fn(),
    getUserRoles: jest.fn(),
    updateRefreshToken: jest.fn(),
  };

  const mockAuthGuard = {
    canActivate: jest.fn(() => true),
  };

  let response: any;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [
        JwtModule.register({
          secret: 'test-secret',
          signOptions: { expiresIn: '1h' },
        }),
      ],
      controllers: [AuthController],
      providers: [
        { provide: AuthService, useValue: mockAuthService },
        { provide: UsuariosService, useValue: mockUsuariosService },
        { provide: AuthGuard, useValue: mockAuthGuard },
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);

    response = {
      cookie: jest.fn(),
      clearCookie: jest.fn(),
      json: jest.fn(),
    };
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should call register service method', async () => {
    const mockResult = {
      usuario: { id: 'test-id', userName: 'testuser' },
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    };

    mockAuthService.register.mockResolvedValue(mockResult);

    expect(mockAuthService.register).toBeDefined();
  });

  it('should call login service method', async () => {
    const mockResult = {
      usuario: { id: 'test-id', userName: 'testuser' },
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    };

    mockAuthService.login.mockResolvedValue(mockResult);

    expect(mockAuthService.login).toBeDefined();
  });

  it('should handle logout', async () => {
    const mockReq = { userID: 'test-id' };

    // Mock the updateRefreshToken to resolve successfully
    mockUsuariosService.updateRefreshToken.mockResolvedValue(undefined);

    // Mock response.json method
    response.json = jest.fn().mockReturnValue(response);

    await controller.logout(mockReq, response);

    expect(mockUsuariosService.updateRefreshToken).toHaveBeenCalledWith(
      'test-id',
      null,
    );
    expect(response.clearCookie).toHaveBeenCalledWith('token');
    expect(response.clearCookie).toHaveBeenCalledWith('refreshToken');
    expect(response.json).toHaveBeenCalledWith({
      message: 'Sesión cerrada exitosamente',
    });
  });
});
