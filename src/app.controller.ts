import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpException,
  HttpStatus,
  Param,
  ParseIntPipe,
  Post,
  Put,
} from '@nestjs/common';
import { AppService } from './app.service';
import { MessageDto } from './message.dto';
import { ValidationPipe } from './validation.pipe';

@Controller('messages')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getMessages(): MessageDto[] {
    return this.appService.getMessages();
  }

  @Get(':id')
  getMessageById(@Param('id', ParseIntPipe) id: number): MessageDto {
    const message = this.appService.getMessageById(+id);

    if (!message) {
      throw new HttpException(
        `Can't find message with given ID.`,
        HttpStatus.NOT_FOUND,
      );
    }

    return message;
  }

  @Post()
  createMessage(
    @Body(new ValidationPipe()) message: MessageDto,
  ): MessageDto | undefined {
    return this.appService.createMessage(message);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() message: MessageDto,
  ): MessageDto | undefined {
    const messageUpdated = this.appService.updateMessage(+id, message);

    if (!messageUpdated) {
      throw new HttpException(
        `Can't find message with given ID.`,
        HttpStatus.NOT_FOUND,
      );
    }

    return messageUpdated;
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id', ParseIntPipe) id: number) {
    const removed = this.appService.removeMessage(id);

    if (!removed) {
      throw new HttpException(
        `Can't find message with given ID.`,
        HttpStatus.NOT_FOUND,
      );
    }
  }
}
