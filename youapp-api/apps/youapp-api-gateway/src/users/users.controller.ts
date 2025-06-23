import { Body, Controller, Delete, Get, Param, Post, Put, UseGuards } from '@nestjs/common';
import { UsersService } from './users.service';
import { AuthGuard } from '../auth/guards/auth.guard';
import { CreateUserProfileDto } from '@app/data-library/dto/create-user-profile.dto';
import { UpdateUserProfileDto } from '@app/data-library/dto/update-user-profile.dto';

@Controller('users')
export class UsersController {
    constructor(private userService: UsersService){}

    @UseGuards(AuthGuard)
    @Post()
    create(@Body() createUserProfileDto: CreateUserProfileDto) {
        return this.userService.create(createUserProfileDto);
    }

    @UseGuards(AuthGuard)
    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.userService.findOne(id);
    }

    @UseGuards(AuthGuard)
    @Get()
    findAll() {
        return this.userService.findAll();
    }

    @UseGuards(AuthGuard)
    @Put(':id')
    update(@Param('id') id: string, @Body() updateUserProfileDto: UpdateUserProfileDto) {
        return this.userService.update(id, updateUserProfileDto);
    }

    @UseGuards(AuthGuard)
    @Delete(':id')
    delete(@Param('id') id: string) {
        return this.userService.delete(id);
    }
}
