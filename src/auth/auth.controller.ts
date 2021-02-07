import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthUser } from '../users/user.decorator';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { UserToken } from './user-token';
import { Prisma, User } from '@prisma/client';
import { UserService } from '../users/user.service';
import { LocalAuthGuard } from './guards/local-auth.guard';
import { JwtAuthGuard } from './guards/jwt-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private userService: UserService,
  ) {}

  @Post('login')
  @UseGuards(LocalAuthGuard)
  @HttpCode(HttpStatus.OK)
  async login(@AuthUser() user: User): Promise<UserToken> {
    return this.authService.login(user);
  }

  @UseGuards(JwtAuthGuard)
  @Post('register')
  async signupUser(@Body() userData: Prisma.UserCreateInput): Promise<User> {
    return this.userService.createUser(userData);
  }
}
