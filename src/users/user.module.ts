import { HttpModule, Module } from '@nestjs/common';
import { UserService } from './user.service';
import { PrismaService } from '../services/prisma.service';
import { UserController } from './user.controller';

@Module({
    imports: [HttpModule],
    providers: [UserService, PrismaService],
    exports: [UserService],
    controllers: [UserController],
})
export class UserModule {}
