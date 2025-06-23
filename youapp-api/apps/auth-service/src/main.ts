import { NestFactory } from '@nestjs/core';
import { AuthAppModule } from './auth-app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  var port = parseInt(process.env.AUTH_PORT ?? '3001') ?? 3001;
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
      AuthAppModule, 
      {
        transport: Transport.TCP,
        options: {
          port: port
        }
      }
    );
  await app.listen();
  console.log(`AUTH Microservice is listening on port ${3001}`);
}
bootstrap();
