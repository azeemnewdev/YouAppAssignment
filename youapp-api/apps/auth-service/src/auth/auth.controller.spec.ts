import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: AuthService;
  const id = Math.floor(Math.random())
  
  const mockCreate = jest.fn();
  const mockLogin = jest.fn();

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        {
          provide: AuthService,
          useValue: {
            create: mockCreate,
            login: mockLogin,
          },
        },
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
  });

  it('Auth Controller Calling create in the Auth Service', () => {
    mockCreate.mockReturnValue({
      message: "User created successfully"
    });
    const result = authService.create({} as CreateUserDto);

    expect(result).toMatchObject({
      message: "User created successfully"
    });
  });

  
  it('Auth Controller Calling login in the Auth Service', async () => {
    mockLogin.mockReturnValue({
      emailAddress:  `randomUser${id}@test.com`,
      accessToken: 'token',
    });
    
    expect(authService.login({} as CreateUserDto)).toMatchObject({
      emailAddress: `randomUser${id}@test.com`,
      accessToken: 'token',
    });
  });
});
