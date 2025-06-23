import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:youapptest/constants/app_constants.dart';
import 'package:youapptest/utility/shared_store.dart';

class TokenUtitlity {
  static Future<bool> isTokenValid() async {
    var token = await SharedStorage.getData(AppConstants.token);

    if (token == null) {
      return false;
    }
    return !JwtDecoder.isExpired(token);
  }
}

class TokenUtils {
  static Future<bool> isTokenValid({
    required Future<String?> Function() getToken,
    required bool Function(String) isTokenExpired,
  }) async {
    final token = await getToken();

    if (token == null) return false;

    return !isTokenExpired(token);
  }
}
