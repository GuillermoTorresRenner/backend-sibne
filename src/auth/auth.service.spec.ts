import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { UsuariosService } from '../usuarios/usuarios.service';
import { JwtService } from '@nestjs/jwt';
import { LoginDto } from './dto/login.dto';
import { CreateUsuarioDto } from '../usuarios/dto/create-usuario.dto';

const mockUsuariosService = {
  validateCredentials: jest.fn(),
  getUserRoles: jest.fn(),
  updateRefreshToken: jest.fn(),
  getRefreshToken: jest.fn(),
  findOne: jest.fn(),
  create: jest.fn(),
};

const mockJwtService = {
  signAsync: jest.fn(),
  verifyAsync: jest.fn(),
};

describe('AuthService', () => {
  let service: AuthService;
  let usuariosService: jest.Mocked<UsuariosService>;
  let jwtService: jest.Mocked<JwtService>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: UsuariosService, useValue: mockUsuariosService },
        { provide: JwtService, useValue: mockJwtService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    usuariosService = module.get(UsuariosService);
    jwtService = module.get(JwtService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('login', () => {
    it('should login successfully and return tokens with user info', async () => {
      const mockUsuario = {
        id: 'test-user-id',
        userName: 'testuser',
        email: 'test@example.com',
        nombre: 'Test',
        apellido: 'User',
      };

      const mockRoles = ['USER'];

      const loginDto: LoginDto = {
        userName: 'testuser',
        password: 'testpassword123',
      };

      mockUsuariosService.validateCredentials.mockResolvedValue(mockUsuario);
      mockUsuariosService.getUserRoles.mockResolvedValue(mockRoles);
      mockJwtService.signAsync
        .mockResolvedValueOnce('access-token')
        .mockResolvedValueOnce('refresh-token');
      mockUsuariosService.updateRefreshToken.mockResolvedValue(undefined);

      const result = await service.login(loginDto);

      expect(result).toEqual({
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        usuario: {
          id: 'test-user-id',
          userName: 'testuser',
          email: 'test@example.com',
          nombre: 'Test',
          apellido: 'User',
          roles: ['USER'],
        },
      });

      expect(mockUsuariosService.validateCredentials).toHaveBeenCalledWith(
        loginDto,
      );
      expect(mockUsuariosService.getUserRoles).toHaveBeenCalledWith(
        'test-user-id',
      );
      expect(mockUsuariosService.updateRefreshToken).toHaveBeenCalledWith(
        'test-user-id',
        'refresh-token',
      );
    });
  });

  describe('register', () => {
    it('should register a new user successfully', async () => {
      const createUserDto: CreateUsuarioDto = {
        id: 'new-user-id',
        userName: 'newuser',
        email: 'new@example.com',
        passwordHash: 'plainpassword',
        nombre: 'New',
        apellido: 'User',
      };

      const mockCreatedUser = {
        ...createUserDto,
        usuarioRoles: [{ role: { name: 'USER' } }],
      };

      mockUsuariosService.create.mockResolvedValue(mockCreatedUser);
      mockUsuariosService.getUserRoles.mockResolvedValue(['USER']);

      const result = await service.register(createUserDto);

      expect(result).toEqual({
        id: 'new-user-id',
        userName: 'newuser',
        email: 'new@example.com',
        nombre: 'New',
        apellido: 'User',
        roles: ['USER'],
      });

      expect(mockUsuariosService.create).toHaveBeenCalledWith(createUserDto);
      expect(mockUsuariosService.getUserRoles).toHaveBeenCalledWith(
        'new-user-id',
      );
    });
  });

  describe('refresh', () => {
    it('should refresh tokens successfully', async () => {
      const userId = 'test-user-id';
      const refreshToken = 'old-refresh-token';

      const mockUsuario = {
        id: userId,
        userName: 'testuser',
        email: 'test@example.com',
        nombre: 'Test',
        apellido: 'User',
      };

      mockUsuariosService.findOne.mockResolvedValue(mockUsuario);
      mockUsuariosService.getRefreshToken.mockResolvedValue(refreshToken);
      mockJwtService.verifyAsync.mockResolvedValue({ id: userId });
      mockUsuariosService.getUserRoles.mockResolvedValue(['USER']);
      mockJwtService.signAsync
        .mockResolvedValueOnce('new-access-token')
        .mockResolvedValueOnce('new-refresh-token');
      mockUsuariosService.updateRefreshToken.mockResolvedValue(undefined);

      const result = await service.refresh(userId, refreshToken);

      expect(result).toEqual({
        accessToken: 'new-access-token',
        refreshToken: 'new-refresh-token',
        usuario: {
          id: userId,
          userName: 'testuser',
          email: 'test@example.com',
          nombre: 'Test',
          apellido: 'User',
          roles: ['USER'],
        },
      });

      expect(mockUsuariosService.findOne).toHaveBeenCalledWith(userId);
      expect(mockUsuariosService.getRefreshToken).toHaveBeenCalledWith(userId);
      expect(mockJwtService.verifyAsync).toHaveBeenCalledWith(refreshToken);
      expect(mockUsuariosService.updateRefreshToken).toHaveBeenCalledWith(
        userId,
        'new-refresh-token',
      );
    });

    it('should throw error for invalid refresh token', async () => {
      const userId = 'test-user-id';
      const refreshToken = 'invalid-refresh-token';

      const mockUsuario = {
        id: userId,
        userName: 'testuser',
        email: 'test@example.com',
      };

      mockUsuariosService.findOne.mockResolvedValue(mockUsuario);
      mockUsuariosService.getRefreshToken.mockResolvedValue('different-token');

      await expect(service.refresh(userId, refreshToken)).rejects.toThrow(
        'Refresh token inválido',
      );
    });
  });
});
