import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { DataModule } from '@app/data-library';

@Module({
  imports:[DataModule],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
