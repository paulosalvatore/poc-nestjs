import { Injectable } from '@nestjs/common';
import { User } from './user';

@Injectable()
export class UsersService {
  private readonly users: User[] = [
    {
      id: 1,
      name: 'John Doe',
      email: 'john@doe.com',
      password: '1234',
    },
    {
      id: 2,
      name: 'Jane Doe',
      email: 'jane@doe.com',
      password: '12345',
    },
  ];

  async findOne(email: string): Promise<User | undefined> {
    return this.users.find(user => user.email === email);
  }
}
