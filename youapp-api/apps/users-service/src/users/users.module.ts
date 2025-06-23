import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { DataModule } from '@app/data-library';

@Module({
  imports: [DataModule],
  controllers: [UsersController],
  providers: [UsersService],
})
export class UsersModule {}
