import { Module } from '@nestjs/common';
import { UserDataService } from './services/user-data.service';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './entities/user.entity';
import { JwtModule } from '@nestjs/jwt';
import { UserProfile, UserProfileSchema } from './entities/user-profile.entity';

// THE DATABASE URL SHOULD BE IN A .ENV file
const uri = "YOU MONGO DB URL GOES HERE";

@Module({
  imports: [
    JwtModule.register({
      global: true,
      secret: 'superSecretKey',
      signOptions: { expiresIn: '10h' },
    }),
    MongooseModule.forRoot(uri),
    MongooseModule.forFeature([
      {
        name: User.name,
        schema: UserSchema
      },
      {
        name: UserProfile.name,
        schema: UserProfileSchema
      }
    ])
  ],
  providers: [UserDataService],
  exports: [UserDataService],
})
export class DataModule {}
