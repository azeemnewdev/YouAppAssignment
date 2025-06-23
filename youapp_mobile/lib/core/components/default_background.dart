import 'package:flutter/widgets.dart';

class DefaultBackground extends StatelessWidget {
  final bool isAuth;
  const DefaultBackground({super.key, required this.isAuth});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: isAuth
            ? LinearGradient(
                colors: [
                  Color(0xFF09141A),
                  Color(0xFF0D1D23),
                  Color(0xFF1F4247),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              )
            : null,
        color: !isAuth ? Color(0xFF09141A) : null,
      ),
    );
  }
}
