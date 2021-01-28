import { Body, Controller, Delete, Get, HttpCode, HttpStatus, Param, Post, Put, Res } from '@nestjs/common';
import { AppService } from './app.service';
import { MessageDto } from './message.dto';
import { Response } from 'express';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getMessages(): MessageDto[] {
    return this.appService.getMessages();
  }

  @Get(':id')
  getMessageById(
    @Param('id') id: string,
    @Res() response: Response,
  ): MessageDto {
    const message = this.appService.getMessageById(+id);

    if (!message) {
      response.status(HttpStatus.NOT_FOUND).send();

      return;
    }

    response.send(message);
  }

  @Post()
  createMessage(@Body() message: MessageDto): MessageDto | undefined {
    return this.appService.createMessage(message);
  }

  @Put(':id')
  update(
    @Param('id') id: string,
    @Body() message: MessageDto,
    @Res() response: Response,
  ): MessageDto | undefined {
    const messageUpdated = this.appService.updateMessage(+id, message);

    if (!messageUpdated) {
      response.status(HttpStatus.NOT_FOUND).send();

      return;
    }

    response.send(messageUpdated);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id') id: string, @Res() response: Response) {
    const removed = this.appService.removeMessage(+id);

    if (!removed) {
      response.status(HttpStatus.NOT_FOUND).send();

      return;
    }

    response.send();
  }
}
