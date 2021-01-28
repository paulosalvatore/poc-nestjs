import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { AppService } from './app.service';
import { MessageDto } from './message.dto';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {
  }

  @Get()
  getMessages(): MessageDto[] {
    return this.appService.getMessages();
  }

  @Get(':id')
  getMessageById(@Param('id') id: string): MessageDto {
    return this.appService.getMessageById(+id);
  }

  @Post()
  createMessage(@Body() message: MessageDto): MessageDto {
    return this.appService.createMessage(message);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() message: MessageDto): MessageDto {
    return this.appService.updateMessage(+id, message);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    this.appService.removeMessage(+id);
  }
}
