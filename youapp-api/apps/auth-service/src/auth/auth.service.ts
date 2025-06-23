import * as bcrypt from 'bcrypt';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UserDataService } from '@app/data-library';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { AuthResponse } from '@app/data-library/dto/auth-response.dto';
import { LoginUserDto } from '@app/data-library/dto/login-user.dto';
import { JwtService } from '@nestjs/jwt';
import { RpcException } from '@nestjs/microservices';
import { BaseResponse } from '@app/data-library/dto/base-response.dto';

@Injectable()
export class AuthService {
  constructor(
    private userDataService: UserDataService,
    private jwtService: JwtService
  ){}

  async create(createUserDto: CreateUserDto) : Promise<BaseResponse>  {
    const saltOrRounds = 10;
    const hash = await bcrypt.hash(createUserDto.password, saltOrRounds);
    createUserDto.password = hash;
    const user = await this.userDataService.RegisterUser(createUserDto);
    if (!user) {
      throw new RpcException({ message: 'User already exists', code: 409 });
    }

    return {
      message: "User created successfully"
    };
  }

  async login(loginUserDto: LoginUserDto) : Promise<AuthResponse> {
    const user = await this.userDataService.Login(loginUserDto);
    if (!user) {
        throw new UnauthorizedException();
    }
    const isMatch = await bcrypt.compare(loginUserDto.password, user?.password);

    if (!isMatch) {
        throw new UnauthorizedException();
    }

    const payload = { sub: user._id, username: user.email };
    return {
        emailAddress: user.email,
        accessToken: await this.jwtService.signAsync(payload),
    };
  }
}
