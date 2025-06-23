import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/features/auth/presentation/bindings/auth_binding.dart';
import 'package:youapptest/features/auth/presentation/screens/login_screen.dart';
import 'package:youapptest/features/auth/presentation/screens/register_screen.dart';
import 'package:youapptest/features/dashbaord/presentation/bindings/user_binding.dart';
import 'package:youapptest/features/dashbaord/presentation/screens/dashboard_screen.dart';
import 'package:youapptest/features/dashbaord/presentation/screens/splash_screen.dart';
import 'package:youapptest/features/dashbaord/presentation/screens/user_interests_screen.dart';
import 'package:youapptest/middlewares/auth_guard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YouApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F4247)),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(),
          middlewares: [AuthGuard()],
          binding: UserBinding(),
        ),
        GetPage(
          name: '/interests',
          page: () => const UserInterestsScreen(),
          middlewares: [AuthGuard()],
          binding: UserBinding(),
        ),
      ],
    );
  }
}
