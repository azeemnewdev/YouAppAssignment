import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { DataModule } from '@app/data-library';
import { ConfigModule } from '@nestjs/config';
import * as path from 'path';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: path.resolve(__dirname, '../../../.env'), 
      isGlobal: true,
    }),
    AuthModule,
    DataModule,
  ],
  controllers: [],
  providers: [],
})
export class AuthAppModule {}
