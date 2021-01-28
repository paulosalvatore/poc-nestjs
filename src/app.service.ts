import { Injectable } from '@nestjs/common';
import { MessageDto } from './message.dto';

@Injectable()
export class AppService {
  private messages: MessageDto[] = [];

  getMessages(): MessageDto[] {
    return this.messages.filter(Boolean);
  }

  getMessageById(id: number): MessageDto | undefined {
    const index = this.messages.findIndex(msg => msg?.id === id);

    return this.messages[index];
  }

  createMessage(message: MessageDto): MessageDto {
    message.id = this.messages.length + 1;

    this.messages.push(message);

    return message;
  }

  updateMessage(id: number, message: MessageDto): MessageDto | undefined {
    if (message.id) {
      delete message.id;
    }

    message.id = id;

    const index = this.messages.findIndex(msg => msg?.id === id);

    if (index < 0) {
      return;
    }

    this.messages[index] = message;

    return message;
  }

  removeMessage(id: number): boolean {
    const index = this.messages.findIndex(msg => msg?.id === id);

    delete this.messages[index];

    return index >= 0;
  }
}
