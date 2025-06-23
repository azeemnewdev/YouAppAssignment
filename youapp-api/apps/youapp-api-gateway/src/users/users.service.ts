import { USERS_CLIENT } from '@app/data-library/constants/app.constants';
import { CreateUserProfileDto } from '@app/data-library/dto/create-user-profile.dto';
import { UpdateUserProfileDto } from '@app/data-library/dto/update-user-profile.dto';
import { Inject, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { ClientProxy, RpcException } from '@nestjs/microservices';
import { catchError, lastValueFrom } from 'rxjs';

@Injectable()
export class UsersService {
    constructor(@Inject(USERS_CLIENT) private usersClient: ClientProxy){}

    async create(createUserProfileDto: CreateUserProfileDto) {
         return this.usersClient.send('users.create', createUserProfileDto).pipe(
            catchError(err => {
                throw new NotFoundException(err.message || 'User not found');
            })
        );
    }

    async findOne(id: string){
        return this.usersClient.send('users.findOne', {id}).pipe(
            catchError(err => {
                throw new NotFoundException(err.message || 'User not found');
            })
        );
    }

    async findAll(){
        return this.usersClient.send('users.findAll', {}).pipe(
            catchError(err => {
                throw new NotFoundException(err.message || 'User not found');
            })
        );
    }

    async update(id: string, updateUserProfileDto: UpdateUserProfileDto) {
        updateUserProfileDto.userId = id;
        return this.usersClient.send('users.update', updateUserProfileDto).pipe(
            catchError(err => {
                throw new NotFoundException(err.message || 'User not found');
            })
        );
    }

    async delete(id: string){
        return this.usersClient.send('users.delete', {id}).pipe(
            catchError(err => {
                throw new NotFoundException(err.message || 'User not found');
            })
        );
    }
}
