import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber } from "class-validator";

export class CreateUserProfileDto {
    @IsNotEmpty()
    @ApiProperty()
    userId: string;

    @IsNotEmpty()
    @ApiProperty()
    name: string;

    @IsNotEmpty()
    @ApiProperty()
    birthday: string;

    @IsNotEmpty()
    @IsNotEmpty()
    @ApiProperty()
    height: number;
    
    @IsNotEmpty()
    @IsNumber()
    @ApiProperty()
    weight: number;

    @ApiProperty()
    interests: string[];
}