import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { DataModule } from '@app/data-library';
import { ConfigModule } from '@nestjs/config';
import * as path from 'path';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: path.resolve(__dirname, '../../../.env'),
      isGlobal: true,
    }),
    UsersModule,
    DataModule,
  ],
  controllers: [],
  providers: [],
})
export class UsersAppModule {}
