import 'package:get/get.dart';
import 'package:youapptest/features/dashbaord/presentation/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
