import 'package:flutter/material.dart';

class YouTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final bool showSufficIcon;
  final Function()? toggleObscureText;
  const YouTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.toggleObscureText,
    required this.showSufficIcon,
  });

  @override
  State<YouTextField> createState() => _YouTextFieldState();
}

class _YouTextFieldState extends State<YouTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: widget.showSufficIcon
              ? GestureDetector(
                  onTap: widget.toggleObscureText,
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.blueGrey,
          filled: true,
          hint: Text(widget.hintText),
          hintStyle: TextStyle(color: Colors.grey[100]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: widget.obscureText,
      ),
    );
  }
}
