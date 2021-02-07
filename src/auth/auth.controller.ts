import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { LocalAuthGuard } from './guards/local-auth.guard';
import { AuthService } from './auth.service';
import { Public } from '../decorators/public.decorator';
import { AuthUser } from '../users/user.decorator';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { UserToken } from './user-token';
import { Prisma, User } from '@prisma/client';
import { UserService } from '../users/user.service';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private userService: UserService,
  ) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@AuthUser() user: User): Promise<UserToken> {
    return this.authService.login(user);
  }

  @Post('register')
  async signupUser(@Body() userData: Prisma.UserCreateInput): Promise<User> {
    return this.userService.createUser(userData);
  }
}
