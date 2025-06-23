import { NestFactory } from '@nestjs/core';
import { UsersAppModule } from './users-app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  var port = parseInt(process.env.USERS_PORT ?? '3002') ?? 3002;
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    UsersAppModule, 
    {
      transport: Transport.TCP,
      options: {
        port: port
      }
    }
  );
  await app.listen();
  console.log(`USERS Microservice is listening on port ${port}`);
}
bootstrap();
