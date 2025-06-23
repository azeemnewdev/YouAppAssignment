import { NestFactory } from '@nestjs/core';
import { YouappApiGatewayModule } from './youapp-api-gateway.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(YouappApiGatewayModule);

  app.useGlobalPipes(new ValidationPipe());
  app.enableCors();

  app.setGlobalPrefix('api');
  // Swagger config
  const config = new DocumentBuilder()
    .setTitle('My API')
    .setDescription('API documentation')
    .setVersion('1.0')
    .addTag('users')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('docs', app, document); 

  const port = parseInt(process.env.GATEWAY_PORT ?? '3000') ?? 3000;

  await app.listen(port);

  console.log(`App is listening on http://localhost:${port}`);
  console.log(`Swagger UI is available at http://localhost:${port}/docs`);
}
bootstrap();