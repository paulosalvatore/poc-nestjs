import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AuthModule } from './auth/auth.module';
import { ProtectedModule } from './protected.module';

@Module({
  imports: [AuthModule, ProtectedModule],
  controllers: [AppController],
})
export class AppModule {}
