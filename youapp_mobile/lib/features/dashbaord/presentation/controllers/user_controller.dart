import 'dart:convert';

import 'package:get/get.dart';
import 'package:youapptest/constants/app_constants.dart';
import 'package:youapptest/features/auth/domain/entities/user.dart';
import 'package:youapptest/features/dashbaord/domain/repositories/user_repository.dart';
import 'package:youapptest/features/dashbaord/domain/repositories/user_repository_impl.dart';
import 'package:youapptest/utility/shared_store.dart';

class UserController extends GetxController {
  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final result = ''.obs;
  final isLoading = true.obs;
  var user = User(email: '').obs;

  late final UserRepository repository;

  @override
  void onInit() {
    repository = UserRepositoryImpl();
    super.onInit();
  }

  Future<void> getProfileFromStorage() async {
    var userFromStorage = await SharedStorage.getData(AppConstants.user);
    if (userFromStorage != null) {
      Map<String, dynamic> userMap = jsonDecode(userFromStorage);
      user.value = User.fromJson(userMap);
    } else {
      getUserProfile();
    }
    isLoading.value = false;
  }

  Future<void> getUserProfile() async {
    var token = await SharedStorage.getData(AppConstants.token);
    var userProfile = await repository.getProfile(token!);
    if (userProfile != null) {
      user.value = userProfile;
    } else {
      result.value = 'Failed to get profile';
    }
    isLoading.value = false;
  }
}
