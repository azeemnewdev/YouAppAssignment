import { Controller } from '@nestjs/common';
import { MessagePattern, Payload, RpcException } from '@nestjs/microservices';
import { UsersService } from './users.service';
import { CreateUserProfileDto } from '@app/data-library/dto/create-user-profile.dto';
import { UpdateUserProfileDto } from '@app/data-library/dto/update-user-profile.dto';

@Controller()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @MessagePattern('users.create')
  create(@Payload() createUserProfileDto: CreateUserProfileDto) {
    try {
      return this.usersService.create(createUserProfileDto);
    } catch (err) {
      throw new RpcException(err.message);
    }
  }

  @MessagePattern('users.findAll')
  findAll() {
    return this.usersService.findAll();
  }

  @MessagePattern('users.findOne')
  findOne(@Payload() data: {id: string}) {
    try {
      return this.usersService.findOne(data.id);
    } catch (err) {
      throw new RpcException(err.message);
    }
  }

  @MessagePattern('users.update')
  update(@Payload() updateUserDto: UpdateUserProfileDto) {
    try {
      return this.usersService.update(updateUserDto.userId, updateUserDto);
    } catch (err) {
      throw new RpcException(err.message);
    }
  }

  @MessagePattern('users.delete')
  remove(@Payload() data: {id: string}) {
    return this.usersService.remove(data.id);
  }
}
