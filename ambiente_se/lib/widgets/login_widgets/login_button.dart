import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 245, 245, 245)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0065A9),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
