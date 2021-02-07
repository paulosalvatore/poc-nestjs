import { Module } from '@nestjs/common';
import { PrismaService } from '../services/prisma.service';
import { PostService } from './post.service';

@Module({
  providers: [PostService, PrismaService],
  exports: [PostService],
})
export class PostModule {}
