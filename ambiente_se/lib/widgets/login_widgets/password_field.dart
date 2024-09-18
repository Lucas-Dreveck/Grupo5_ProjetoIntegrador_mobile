import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Senha',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 30, 30, 30),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          width: 300,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Senha',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 80, 80, 80),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              filled: true,
              fillColor: const Color(0xFFD5E2E7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
