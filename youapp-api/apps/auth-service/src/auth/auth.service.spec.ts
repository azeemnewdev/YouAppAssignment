import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { JwtService } from '@nestjs/jwt';
import { UserDataService } from '@app/data-library';
import { UnauthorizedException } from '@nestjs/common';
import { User } from '@app/data-library/entities/user.entity';
import { RpcException } from '@nestjs/microservices';

describe('AuthService', () => {
  let authService: AuthService;
  let userDataService: UserDataService;
  let jwtService: JwtService;
  
  const mockDataServiceRegisterUser = jest.fn();
  const mockDataServiceLogin = jest.fn();
  const mockSignAsync = jest.fn();
  const mockAuthServiceLogin = jest.fn();

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthService],
      providers: [
        {
          provide: UserDataService,
          useValue: {
            RegisterUser: mockDataServiceRegisterUser,
            Login: mockDataServiceLogin,
          },
        },
        {
          provide: JwtService,
          useValue: {
            signAsync: mockSignAsync
          },
        },
        {
          provide: AuthService,
          useValue: {
            login: mockAuthServiceLogin
          },
        },
      ],
    }).compile();

    userDataService = module.get<UserDataService>(UserDataService);
    jwtService = module.get<JwtService>(JwtService);
    authService = module.get<AuthService>(AuthService);
  });

  it('Registering a User calling the register user method', () => {
    mockDataServiceRegisterUser.mockReturnValueOnce({ message: "User created successfully" });

    const id = Math.floor(Math.random());
    const result = userDataService.RegisterUser({
      email: `randomUser${id}@test.com`,
      username: `randomUser${id}`,
      password: `password123456`,
    } as CreateUserDto);

    expect(result).toMatchObject({
      message: "User created successfully",
    });
  });

  it('Registering a User user already exists expect error', async () => {
    mockDataServiceRegisterUser.mockReturnValueOnce(null);

    userDataService.Login({} as CreateUserDto);

    await expect(authService.create({password: 'newPassword'} as CreateUserDto))
    .rejects
    .toThrow(RpcException);
  });

  
  it('Login user with correct credentials expect success', () => {
    const id = Math.floor(Math.random());
    mockDataServiceLogin.mockReturnValueOnce({
      emailAddress: `randomUser${id}@test.com`,
      accessToken: 'token',
    });

    const result = userDataService.Login({
      email: `randomUser${id}@test.com`,
      username: `randomUser${id}`,
      password: `password123456`,
    } as CreateUserDto);

    expect(result).toMatchObject({
      emailAddress: `randomUser${id}@test.com`,
      accessToken: 'token',
    });
  });

  it('Login called and user does not exist expect unauthorized', async () => {
    mockDataServiceLogin.mockReturnValueOnce(null);

    userDataService.Login({} as CreateUserDto);

    await expect(authService.login({} as CreateUserDto))
    .rejects
    .toThrow(UnauthorizedException);
  });

  it('Login called and user exists but wrong password expect unauthorized', async () => {
    mockDataServiceLogin.mockReturnValueOnce({password: 'correctPassword'} as User);

    userDataService.Login({password: 'wrongPassword'} as CreateUserDto);

    await expect(authService.login({password: 'wrongPassword'} as CreateUserDto))
    .rejects
    .toThrow(UnauthorizedException);
  });
});
