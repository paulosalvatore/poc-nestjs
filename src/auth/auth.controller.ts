import { Controller, Get, Post, UseGuards } from '@nestjs/common';
import { LocalAuthGuard } from './guards/local-auth.guard';
import { AuthService } from './auth.service';
import { Public } from '../decorators/public.decorator';
import { User } from '../users/user';
import { AuthUser } from '../users/user.decorator';
import { UserToken } from './user-token';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@AuthUser() user: User): Promise<UserToken> {
    return this.authService.login(user);
  }

  @Get('profile')
  getProfile(@AuthUser() user: User): User {
    return user;
  }
}
