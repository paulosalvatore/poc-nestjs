import { NestFactory } from '@nestjs/core';
import { GuardModule } from './guard.module';
import * as helmet from 'helmet';
import * as rateLimit from 'express-rate-limit';
import { NestExpressApplication } from '@nestjs/platform-express';

async function bootstrap() {
    const app = await NestFactory.create<NestExpressApplication>(GuardModule, {
        cors: true,
    });

    app.use(helmet());

    app.use(
        rateLimit({
            windowMs: 15 * 60 * 1000, // 15 minutes
            max: 100, // limit each IP to 100 requests per windowMs
        }),
    );

    await app.listen(3000);
}

bootstrap();
