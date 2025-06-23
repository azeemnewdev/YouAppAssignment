import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { ObjectId } from "mongoose";

@Schema()
export class UserProfile {
    _id: ObjectId;
    @Prop({ required: true})
    userId: string;
    @Prop({ required: true})
    name: string;
    @Prop({ required: true})
    birthday: Date;
    @Prop({ required: true})
    height: number;
    @Prop({ required: true})
    weight: number;
    @Prop({ required: true})
    horoscope: string;
    @Prop({ required: true})
    zodiac: string;
    @Prop({ required: false})
    interests: string[];
    @Prop({ default: () => new Date()})
    createdAt: Date;
    @Prop({ required: false})
    updatedAt: Date;
}

export const UserProfileSchema = SchemaFactory.createForClass(UserProfile);

UserProfileSchema.pre('deleteOne', async function (next) {
  const userProfile = await this.model.findOne(this.getQuery());
  if (userProfile) {
    const userModel = this.model.db.model('User');
    const id = userProfile.userId as ObjectId;
    await userModel.deleteOne({
            '_id': id
    });
  }
  next();
});