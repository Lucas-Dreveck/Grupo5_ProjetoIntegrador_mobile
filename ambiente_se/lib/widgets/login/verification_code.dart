import 'package:flutter/material.dart';

class VerificationCodeField extends StatefulWidget {
  const VerificationCodeField({super.key});

  @override
  _VerificationCodeFieldState createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Código de verificação',
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
            obscureText: _isObscured,
            decoration: InputDecoration(
              hintText: '********',
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
              suffixIcon: IconButton(
                icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                color: const Color.fromARGB(255, 140, 140, 140),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
