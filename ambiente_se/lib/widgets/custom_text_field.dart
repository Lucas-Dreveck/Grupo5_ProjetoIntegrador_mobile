import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color fillColor;


  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.fillColor = const Color(0xFFD5E2E7),
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: fillColor,
        filled: true,
      ),
    );
  }
}
