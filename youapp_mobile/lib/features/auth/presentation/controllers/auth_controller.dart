import 'package:get/get.dart';
import 'package:youapptest/constants/app_constants.dart';
import 'package:youapptest/features/auth/domain/dto/login_user_dto.dart';
import 'package:youapptest/features/auth/domain/dto/register_user_dto.dart';
import 'package:youapptest/features/auth/domain/entities/user.dart';
import 'package:youapptest/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapptest/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:youapptest/utility/shared_store.dart';

class AuthController extends GetxController {
  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final result = ''.obs;
  late User? user;

  late final AuthRepository repository;

  @override
  void onInit() {
    repository = AuthRepositoryImpl();
    super.onInit();
  }

  Future<void> login() async {
    var data = LoginUserDto(email.value, password.value);
    user = await repository.login(data);
    if (user != null) {
      SharedStorage.saveData(AppConstants.token, user!.accessToken!);
      Get.offAllNamed('/dashboard');
    } else {
      result.value = 'Login failed';
    }
  }

  Future<void> register() async {
    var data = RegisterUserDto(email.value, username.value, password.value);
    user = await repository.register(data);
    if (user != null) {
      Get.offAllNamed('/login');
    } else {
      result.value = 'Registering User failed';
    }
  }
}
