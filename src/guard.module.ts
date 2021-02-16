import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { AppModule } from './app.module';

@Module({
    imports: [AuthModule, AppModule],
})
export class GuardModule {}
