import { AUTH_CLIENT } from '@app/data-library/constants/app.constants';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { LoginUserDto } from '@app/data-library/dto/login-user.dto';
import { HttpException, HttpStatus, Inject, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { ClientProxy, RpcException } from '@nestjs/microservices';
import { catchError } from 'rxjs';

@Injectable()
export class AuthService {
  
  constructor(@Inject(AUTH_CLIENT) private authClient: ClientProxy){}
  
  create(createUserDto: CreateUserDto) {
    return this.authClient.send('auth.create', createUserDto).pipe(
        catchError(err => {
          throw new HttpException(err.message || 'Something went wrong', err.statusCode || HttpStatus.CONFLICT);
        })
    );
  }

  login (loginUserDto: LoginUserDto) {
    return this.authClient.send('auth.login', loginUserDto).pipe(
        catchError(err => {
            throw new UnauthorizedException(err.message || 'Something went wrong');
        })
    );
  }
}
