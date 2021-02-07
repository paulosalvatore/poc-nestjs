import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './users/user.module';
import { MessageModule } from './messages/message.module';
import { PostModule } from './posts/post.module';

@Module({
  imports: [AuthModule, UserModule, MessageModule, PostModule, UserModule],
  controllers: [AppController],
})
export class AppModule {}
