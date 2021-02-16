import { Body, Controller, Post } from '@nestjs/common';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { Prisma, User } from '@prisma/client';
import { UserService } from './user.service';

@Controller('users')
export class UserController {
    constructor(private userService: UserService) {}

    @Post()
    async signupUser(@Body() userData: Prisma.UserCreateInput): Promise<User> {
        return this.userService.createUser(userData);
    }
}
