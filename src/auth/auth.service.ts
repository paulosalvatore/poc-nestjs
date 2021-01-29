import { Injectable } from '@nestjs/common';
import { UserService } from '../users/user.service';
import { User } from '../users/user';
import { JwtService } from '@nestjs/jwt';
import { UserToken } from './user-token';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UserService,
    private jwtService: JwtService,
  ) {}

  async validateUser(
    email: string,
    pass: string,
  ): Promise<Partial<User> | undefined> {
    const user = await this.usersService.findOne(email);

    if (user && user.password === pass) {
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      const { password, ...result } = user;

      return result;
    }
  }

  async login(user: User): Promise<UserToken> {
    const payload = { username: user.email, sub: user.id };

    return {
      accessToken: this.jwtService.sign(payload),
    };
  }
}
