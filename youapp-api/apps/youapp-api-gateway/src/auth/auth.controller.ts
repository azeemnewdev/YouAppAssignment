import { Controller, Post, Body, Inject, Get} from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { LoginUserDto } from '@app/data-library/dto/login-user.dto';
import { catchError, throwError } from 'rxjs';
import { AUTH_CLIENT } from '@app/data-library/constants/app.constants';
import { ClientProxy } from '@nestjs/microservices';

@Controller('auth')
export class AuthController {
  constructor(
    @Inject(AUTH_CLIENT) private readonly client: ClientProxy,
    private readonly authService: AuthService
  ) {}

  @Get('test-auth')
  async testAuth() {
    return this.client.send({ cmd: 'ping' }, {});
  }

  @Post('register')
  create(@Body() createAuthDto: CreateUserDto) {
    return this.authService.create(createAuthDto).pipe(
      catchError(err => {
        const error = typeof err === 'string' ? { message: err } : err;
        return throwError(() => error);
      })
    );
  }

  @Post('login')
  login(@Body() loginUserDto: LoginUserDto) {
    return this.authService.login(loginUserDto).pipe(
      catchError(err => {
        const error = typeof err === 'string' ? { message: err } : err;
        return throwError(() => error);
      })
    );
  }
}
