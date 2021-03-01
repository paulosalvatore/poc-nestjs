import {
    BadRequestException,
    Body,
    Controller,
    Get,
    Post,
    ValidationPipe,
} from '@nestjs/common';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { User } from '@prisma/client';
import { PokemonApiResult, UserService } from './user.service';
import { Public } from '../auth/public.decorator';
import { CreateUserDto } from './dto/CreateUserDto';
import { AxiosResponse } from 'axios';

const validationPipe = new ValidationPipe({
    exceptionFactory: errors => new BadRequestException(errors),
});

@Controller('users')
export class UserController {
    constructor(private userService: UserService) {}

    @Public()
    @Get()
    async test(): Promise<AxiosResponse<PokemonApiResult>> {
        return this.userService.findAll().toPromise();
    }

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
