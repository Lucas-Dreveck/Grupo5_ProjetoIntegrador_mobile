import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;

  const EmailField({
    super.key,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usuário ou email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 30, 30, 30),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          width: 300,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Insira seu usuário ou email',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 80, 80, 80),
              ),
              errorText: errorText,
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
