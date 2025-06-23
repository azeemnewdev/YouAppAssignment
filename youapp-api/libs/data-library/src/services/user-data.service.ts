import { Injectable } from '@nestjs/common';
import { DeleteResult, isValidObjectId, Model } from 'mongoose';
import { User } from '../entities/user.entity';
import { InjectModel } from '@nestjs/mongoose';
import { CreateUserDto } from '../dto/create-user.dto';
import { LoginUserDto } from '../dto/login-user.dto';
import { UserProfile } from '../entities/user-profile.entity';
import { CreateUserProfileDto } from '../dto/create-user-profile.dto';
import { RpcException } from '@nestjs/microservices';
import { BaseResponse } from '../dto/base-response.dto';
import { getYearAnimal, getZodiacSign } from '../util/date.util';

@Injectable()
export class UserDataService {
    constructor(
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(UserProfile.name) private userProfileModel: Model<UserProfile>
    ){}

    async RegisterUser(createUserDto: CreateUserDto) {
        const existingUser = await this.userModel.findOne({
            'email': createUserDto.email
        });
        if (existingUser) {
             throw new RpcException('User already exists');
        }
        return await this.userModel.create(createUserDto);
    }

    async Login(loginDto: LoginUserDto) : Promise<User> {
        const user = await this.userModel.findOne({
            'email': loginDto.email,
            'isActive': true
        })
        return user as User;
    }

    async CreateUserProfile(createUserDto: CreateUserProfileDto) {
        const userProfile = await this.userProfileModel.findOne({
            'userId': createUserDto.userId
        });
        if (userProfile) {
            this.UpdateUserProfile(createUserDto.userId, createUserDto);
        }
        const data = createUserDto as unknown as UserProfile;
        data.birthday = new Date(createUserDto.birthday);
        data.zodiac = getZodiacSign(data.birthday);
        data.horoscope = getYearAnimal(data.birthday);
        return await this.userProfileModel.create(data);
    }
    
    async GetAllProfiles(): Promise<UserProfile[]> {
        const userProfiles = await this.userProfileModel.find({});
        if (!userProfiles) {
             throw new RpcException('No Profiles Found');
        }

        return userProfiles as UserProfile[];
    }
    

    async GetUserProfile(userId: string): Promise<UserProfile> {
        if (!isValidObjectId(userId)) {
            throw new RpcException('Invalid user ID');
        }
        const userProfile = await this.userProfileModel.findOne({
            'userId': userId
        });

        if (!userProfile) {
             throw new RpcException('No Profile Found');
        }

        return userProfile as UserProfile;
    }
    
    async UpdateUserProfile(id: string, data: CreateUserProfileDto): Promise<BaseResponse> {
        let existingUser = await this.GetUserProfile(id);

        let horoscope = existingUser.horoscope ?? '';
        let zodiac = existingUser.zodiac ?? '';;

        const birthday = new Date(data.birthday);

        if (birthday !== existingUser.birthday) {
            zodiac = getZodiacSign(birthday);
            horoscope = getYearAnimal(birthday);
        }

        const response = await this.userProfileModel.updateOne({ userId: data.userId }, 
            { 
                $set: {
                    name: data.name,
                    height: data.height,
                    weight: data.weight,
                    birthday,
                    interests: data.interests,
                    horoscope,
                    zodiac,
                    updatedAt: new Date()
                } 
            }
        )
        .then(result => {
            if (result.modifiedCount > 0) {
                return {
                    message: 'User updated successfully'
                };
            } else {
                return {
                    message: 'Nothing to update'
                };
            }
            
        })
        .catch(error => {
            throw new RpcException({ message: error, code: 409 });
        });

        return response;
    }

    async DeleteUserProfile(userId: string): Promise<DeleteResult> {
        if (!isValidObjectId(userId)) {
            throw new RpcException('Invalid user ID');
        }
        const userProfile = await this.userProfileModel.findOne({
            'userId': userId
        });

        if (!userProfile) {
             throw new RpcException('No Profile Found');
        }

        // Delete the user profile and User
        return await this.userProfileModel.deleteOne({ userId });
    }
}
