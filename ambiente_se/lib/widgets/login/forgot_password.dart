import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPassword({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Esqueceu sua senha?',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 140, 140, 140)),
      ),
    );
  }
}
