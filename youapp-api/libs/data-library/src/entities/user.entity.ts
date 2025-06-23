import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { ObjectId } from "mongoose";

@Schema()
export class User {
    _id: ObjectId;
    @Prop({ required: true})
    email: string;
    @Prop({ required: true})
    username: string;
    @Prop({ required: true})
    password: string;
    @Prop({ required: true, default: () => false})
    emailVerified: boolean;
    @Prop({ required: true, default: () => true})
    isActive: boolean;
    @Prop({ default: () => new Date()})
    createdAt: Date;
    @Prop({ required: false})
    updatedAt: Date;
}

export const UserSchema = SchemaFactory.createForClass(User);