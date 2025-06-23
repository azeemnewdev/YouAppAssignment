import { Catch, ArgumentsHost, HttpStatus, HttpException } from '@nestjs/common';
import { BaseRpcExceptionFilter } from '@nestjs/microservices';
import { BaseExceptionFilter } from '@nestjs/core';
import { Request, Response } from 'express';

@Catch()
export class RpcGlobalExceptionFilter extends BaseRpcExceptionFilter {
  catch(exception: any, host: ArgumentsHost) {
    console.error('Unhandled RPC error:', exception);
    return super.catch(exception, host);
  }
}