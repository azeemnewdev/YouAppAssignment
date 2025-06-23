import { Injectable } from '@nestjs/common';
import { CreateMessageDto } from './dto/create-message.dto';
import { UpdateMessageDto } from './dto/update-message.dto';

@Injectable()
export class MessagesService {

  chats: CreateMessageDto[] = []

  create(createMessageDto: CreateMessageDto) {
    createMessageDto.id = this.chats.length + 1;
    this.chats.push(createMessageDto);
    return createMessageDto;
  }

  findAll() {
    return this.chats;
  }

  findOne(id: number) {
    return `This action returns a #${id} message`;
  }

  update(id: number, updateMessageDto: UpdateMessageDto) {
    return `This action updates a #${id} message`;
  }

  remove(id: number) {
    return `This action removes a #${id} message`;
  }
}
