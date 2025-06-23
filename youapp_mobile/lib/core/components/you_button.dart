import 'package:flutter/material.dart';

class YouButton extends StatelessWidget {
  final Function()? onTap;
  const YouButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.cyan, Colors.lightBlue]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
