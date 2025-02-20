import 'package:flutter/material.dart';
import 'package:ambiente_se/screens/login/verify_code.dart';

class RecoverPasswordButton extends StatefulWidget {
  final Future<void> Function() onPressed;

  const RecoverPasswordButton({super.key, required this.onPressed});

  @override
  _RecoverPasswordButtonState createState() => _RecoverPasswordButtonState();
}

class _RecoverPasswordButtonState extends State<RecoverPasswordButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Aumenta a altura para evitar o corte do texto
      width: 300,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  await widget.onPressed();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyCode()),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0065A9),
          padding: const EdgeInsets.symmetric(vertical: 12), // Ajusta o padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'Recuperar senha',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 245, 245, 245),
                ),
              ),
      ),
    );
  }
}
