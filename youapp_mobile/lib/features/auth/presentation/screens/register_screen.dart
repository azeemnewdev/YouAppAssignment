import 'package:flutter/material.dart';
import 'package:youapptest/core/components/default_background.dart';
import 'package:youapptest/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.9;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DefaultBackground(isAuth: true),
            SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Center(child: RegisterForm()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
