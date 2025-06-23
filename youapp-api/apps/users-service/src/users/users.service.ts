import { UserDataService } from '@app/data-library';
import { CreateUserProfileDto } from '@app/data-library/dto/create-user-profile.dto';
import { CreateUserDto } from '@app/data-library/dto/create-user.dto';
import { UpdateUserProfileDto } from '@app/data-library/dto/update-user-profile.dto';
import { Injectable } from '@nestjs/common';
import { RpcException } from '@nestjs/microservices';

@Injectable()
export class UsersService {
  constructor(
    private userDataService: UserDataService
  ) {}

  async create(createUserProfileDto: CreateUserProfileDto) {
    try { 
      return await this.userDataService.CreateUserProfile(createUserProfileDto);
    } catch (err) {
      throw new RpcException({ message: err.message, code: 500 });
    }
  }

  async findAll() {
    return await this.userDataService.GetAllProfiles();
  }

  async findOne(id: string) {
    try {  
      return await this.userDataService.GetUserProfile(id);
    } catch (err) {
      throw new RpcException({ message: err.message, code: 500 });
    }
  }

  async update(id: string, updateUserProfileDto: UpdateUserProfileDto) {
    try {  
      const user = await this.userDataService.UpdateUserProfile(id, updateUserProfileDto);
      return user;
    } catch (err) {
      throw new RpcException({ message: err.message, code: 500 });
    }
  }

  async remove(id: string) {
    try {
      return await this.userDataService.DeleteUserProfile(id);
    } catch (err) {
      throw new RpcException({ message: err.message, code: 500 });
    }
  }
}
