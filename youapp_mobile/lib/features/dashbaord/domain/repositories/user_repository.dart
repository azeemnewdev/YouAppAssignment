import 'package:youapptest/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getProfile(String token);
}
