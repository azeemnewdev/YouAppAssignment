import { User } from "@app/data-library/entities/user.entity";
import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(private jwtService: JwtService) {}
    async canActivate(context: ExecutionContext){
        const request = context.switchToHttp().getRequest();
        const authorization = request.headers.authorization;
        const token = authorization;

        if (!token) {
            throw new UnauthorizedException();
        }

        try {
            const tokenPayload = await this.jwtService.verifyAsync(token);

            request.user = {
                _id: tokenPayload.sub,
                username: tokenPayload.username
            } as User;
            return true;
        } catch (error) {
            throw new UnauthorizedException();
        }

    }
}