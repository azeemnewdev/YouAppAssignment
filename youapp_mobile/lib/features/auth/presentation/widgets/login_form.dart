import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/core/components/you_button.dart';
import 'package:youapptest/core/components/you_textfield.dart';
import 'package:youapptest/features/auth/presentation/controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final controller = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePasswordText = true;

  void _togglePasswordView() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  Future<void> login() async {
    controller.email.value = _emailController.text;
    controller.password.value = _passwordController.text;
    await controller.login();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: 50),

            Icon(Icons.lock, size: 100, color: Colors.white),

            SizedBox(height: 25),
          ],
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            YouTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
              showSufficIcon: false,
            ),

            SizedBox(height: 25),
            YouTextField(
              hintText: 'Password',
              obscureText: _obscurePasswordText,
              controller: _passwordController,
              showSufficIcon: true,
              toggleObscureText: _togglePasswordView,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            YouButton(onTap: login),
            SizedBox(height: 50),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () => Get.toNamed('/register'),
                child: Text(
                  'Register here',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
