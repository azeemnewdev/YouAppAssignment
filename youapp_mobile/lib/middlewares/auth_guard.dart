import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/utility/token_util.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    TokenUtitlity.isTokenValid().then((isValid) {
      if (!isValid) {
        return const RouteSettings(name: '/login');
      }
    });
    return null;
  }
}
