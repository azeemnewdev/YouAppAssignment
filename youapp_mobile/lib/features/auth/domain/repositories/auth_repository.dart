import 'package:youapptest/features/auth/domain/dto/login_user_dto.dart';
import 'package:youapptest/features/auth/domain/dto/register_user_dto.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(LoginUserDto user);
  Future<User?> register(RegisterUserDto user);
}
