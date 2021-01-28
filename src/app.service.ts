import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  private data = 'NO_DATA';

  getHello(): string {
    return this.data;
  }

  createHello(name: string) {
    this.data = name;
  }
}
