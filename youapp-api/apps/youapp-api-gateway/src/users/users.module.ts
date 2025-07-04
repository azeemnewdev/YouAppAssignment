import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { DataModule } from '@app/data-library';
import { USERS_CLIENT } from '@app/data-library/constants/app.constants';

@Module({
  imports: [
    DataModule,
    ClientsModule.register([
      {
        name: USERS_CLIENT,
        transport: Transport.TCP,
        options: {
          port: 3002
        }
      }
    ])
  ],
  providers: [UsersService],
  controllers: [UsersController]
})
export class UsersModule {}
