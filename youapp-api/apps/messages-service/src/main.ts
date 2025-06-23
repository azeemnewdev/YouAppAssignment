import { NestFactory } from '@nestjs/core';
import { MessagesAppModule } from './messages-app.module';

async function bootstrap() {
  var port = parseInt(process.env.MESSAGES_PORT ?? '4000') ?? 4000;
  const app = await NestFactory.create(MessagesAppModule);
  app.enableCors({
    origin: '*',
    method: '*',
    headers: '*'
  }); // for WebSocket CORS
  await app.listen(port);
  console.log(`MESSAGES Microservice is listening on port ${port}`);
}
bootstrap();
