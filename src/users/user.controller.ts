import {
    BadRequestException,
    Body,
    Controller,
    Post,
    ValidationPipe,
} from '@nestjs/common';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { User } from '@prisma/client';
import { UserService } from './user.service';
import { Public } from '../auth/public.decorator';
import { CreateUserDto } from './dto/CreateUserDto';

const validationPipe = new ValidationPipe({
    exceptionFactory: errors => new BadRequestException(errors),
});

@Controller('users')
export class UserController {
    constructor(private userService: UserService) {}

    @Public()
    @Post()
    async signupUser(
        @Body(validationPipe)
        userData: CreateUserDto,
    ): Promise<User> {
        return this.userService.createUser(userData).catch(e => {
            throw new BadRequestException(e.message);
        });
    }
}
