import {
  BadRequestException,
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
  ValidationPipe,
} from '@nestjs/common';
import { MessageService } from './message.service';
import { Public } from '../decorators/public.decorator';
import { MessageDto } from './message.dto';

@Controller('messages')
export class MessageController {
  constructor(private readonly appService: MessageService) {}

  @Public()
  @Get()
  getMessages(): MessageDto[] {
    return this.appService.getMessages();
  }

  @Get(':id')
  getMessageById(@Param('id', ParseIntPipe) id: number): MessageDto {
    const message = this.appService.getMessageById(+id);

    if (!message) {
      throw new HttpException(
        `Can't find any element with this given ID.`,
        HttpStatus.NOT_FOUND,
      );
    }

    return message;
  }

  @Post()
  createMessage(
    @Body(
      new ValidationPipe({
        exceptionFactory: errors => new BadRequestException(errors),
      }),
    )
    message: MessageDto,
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
        `Can't find any element with this given ID.`,
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
        `Can't find any element with this given ID.`,
        HttpStatus.NOT_FOUND,
      );
    }
  }
}
