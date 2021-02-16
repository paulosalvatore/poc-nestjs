import {
    Controller,
    HttpCode,
    HttpStatus,
    Post,
    UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthUser } from '../users/user.decorator';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { UserToken } from './user-token';
import { User } from '@prisma/client';
import { Public } from './public.decorator';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Public()
    @Post('login')
    @HttpCode(HttpStatus.OK)
    async login(@AuthUser() user: User): Promise<UserToken> {
        return this.authService.login(user).catch(e => {
            throw new UnauthorizedException(e.message);
        });
    }
}
