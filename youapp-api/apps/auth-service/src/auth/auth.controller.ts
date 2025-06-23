import { Controller } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { AuthService } from './auth.service';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { LoginUserDto } from '@app/data-library/dto/login-user.dto';

@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @MessagePattern({ cmd: 'ping' })
  handlePing() {
    return 'pong from auth service';
  }
  
  @MessagePattern('auth.create')
  async create(@Payload() createAuthDto: CreateUserDto) {
    return await this.authService.create(createAuthDto);
  }

  @MessagePattern('auth.login')
  async login(@Payload() loginUserDto: LoginUserDto) {
    return await this.authService.login(loginUserDto);
  }
}
