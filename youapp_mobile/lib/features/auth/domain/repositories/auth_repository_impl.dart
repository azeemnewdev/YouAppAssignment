import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youapptest/constants/app_constants.dart';
import 'package:youapptest/features/auth/domain/dto/login_user_dto.dart';
import 'package:youapptest/features/auth/domain/dto/register_user_dto.dart';
import 'package:youapptest/features/auth/domain/entities/user.dart';
import 'package:youapptest/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapptest/utility/message_util.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> login(LoginUserDto user) async {
    var username = user.email.split('@')[0];
    var data = jsonEncode({
      'email': user.email,
      'username': username,
      'password': user.password,
    });

    final url = Uri.parse('${AppConstants.apiUrl}/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        MessageUtil.showSuccessMessage(responseData);
        return User(
          email: user.email,
          accessToken: responseData['access_token'],
        );
      } else {
        MessageUtil.showErrorMessage(responseData);

        return null;
      }
    } catch (e) {
      MessageUtil.showErrorMessage({'message': 'Something went wrong'});

      return null;
    }
  }

  @override
  Future<User?> register(RegisterUserDto user) async {
    var data = jsonEncode({
      'email': user.email,
      'username': user.username,
      'password': user.password,
    });
    final url = Uri.parse('${AppConstants.apiUrl}/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        MessageUtil.showSuccessMessage(responseData);
        return User(email: user.email);
      } else {
        MessageUtil.showErrorMessage(responseData);
        return null;
      }
    } catch (e) {
      MessageUtil.showErrorMessage({'message': 'Something went wrong'});
      return null;
    }
  }
}
