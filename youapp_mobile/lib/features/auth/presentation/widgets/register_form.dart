import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapptest/core/components/you_button.dart';
import 'package:youapptest/core/components/you_textfield.dart';
import 'package:youapptest/features/auth/presentation/controllers/auth_controller.dart';
import 'package:youapptest/utility/message_util.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  void _togglePasswordView() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _obscureConfirmPasswordText = !_obscureConfirmPasswordText;
    });
  }

  final controller = Get.find<AuthController>();

  Future<void> register() async {
    if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim()) {
      MessageUtil.showErrorMessage({'message': 'Passwords don\'t match'});
      return;
    }

    controller.email.value = _emailController.text;
    controller.username.value = _usernameController.text;
    controller.password.value = _passwordController.text;
    await controller.register();
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
                    'Register',
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
              hintText: 'Username',
              obscureText: false,
              controller: _usernameController,
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

            SizedBox(height: 25),
            YouTextField(
              hintText: 'Confirm Password',
              obscureText: _obscureConfirmPasswordText,
              controller: _passwordConfirmController,
              showSufficIcon: true,
              toggleObscureText: _toggleConfirmPasswordView,
            ),
            const SizedBox(height: 20),
            YouButton(onTap: register),
            SizedBox(height: 50),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Have an account?', style: TextStyle(color: Colors.white)),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () => Get.toNamed('/login'),
                child: Text(
                  'Login here',
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
