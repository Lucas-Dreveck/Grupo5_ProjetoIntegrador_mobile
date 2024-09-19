import 'package:flutter/material.dart';

class VoltarLogin extends StatelessWidget {
  final VoidCallback onPressed;

  const VoltarLogin({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Voltar ao login?',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 140, 140, 140)),
      ),
    );
  }
}
