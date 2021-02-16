import { Injectable } from '@nestjs/common';
import { UserService } from '../users/user.service';
import { User } from '@prisma/client';
import { JwtService } from '@nestjs/jwt';
import { UserToken } from './user-token';
import * as bcrypt from 'bcrypt';

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
        const user = await this.usersService.user({ email });

        if (user && (await bcrypt.compare(pass, user?.password))) {
            // eslint-disable-next-line @typescript-eslint/no-unused-vars
            const { password, ...result } = user;

            return result;
        } else {
            throw Error(`User wasn't found.`);
        }
    }

    async login({ email, password }: User): Promise<UserToken> {
        const user = await this.validateUser(email, password);

        console.log(user);

        const payload = { username: user.email, sub: user.id };

        return {
            accessToken: this.jwtService.sign(payload),
        };
    }
}
