import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './users/user.module';
import { APP_GUARD } from '@nestjs/core';
import { JwtAuthGuard } from './auth/guards/jwt-auth.guard';
import { MessageModule } from './messages/message.module';
import { PostService } from './services/post.service';
import { UserService } from './services/user.service';
import { PrismaService } from './services/prisma.service';

@Module({
  imports: [AuthModule, UserModule, MessageModule],
  controllers: [AppController],
  providers: [
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    PrismaService,
    PostService,
    UserService,
  ],
})
export class AppModule {}
