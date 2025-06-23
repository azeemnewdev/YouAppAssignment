import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youapptest/constants/app_constants.dart';
import 'package:youapptest/features/auth/domain/entities/user.dart';
import 'package:youapptest/features/dashbaord/domain/repositories/user_repository.dart';
import 'package:youapptest/utility/message_util.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User?> getProfile(String token) async {
    final url = Uri.parse('${AppConstants.apiUrl}/getProfile');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'x-access-token': token},
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        MessageUtil.showSuccessMessage(responseData);
        return User.fromJson(responseData['data']);
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
