import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/utility/message_util.dart';
import 'package:youapptest/utility/token_util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _checkLoginStatus() async {
    final isValid = await TokenUtitlity.isTokenValid();

    if (isValid) {
      Get.offAllNamed('/dashboard');
    } else {
      MessageUtil.showErrorMessage({
        "message": "Session Expired! Login again.",
      });
      Get.offAllNamed('/login');
    }
  }
}
