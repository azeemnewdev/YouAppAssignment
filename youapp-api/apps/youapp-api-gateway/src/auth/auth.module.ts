import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { DataModule } from '@app/data-library';
import { AUTH_CLIENT } from '@app/data-library/constants/app.constants';

@Module({
  imports: [
    DataModule,
    ClientsModule.register([
      {
        name: AUTH_CLIENT,
        transport: Transport.TCP,
        options: {
          port: 3001
        }
      }
    ])
  ],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
