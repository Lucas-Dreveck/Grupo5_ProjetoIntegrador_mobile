import 'package:ambiente_se/screens/login/new_password.dart';
import 'package:flutter/material.dart';

class VerifyCodeButton extends StatefulWidget {
  final Future<void> Function() onPressed;

  const VerifyCodeButton({super.key, required this.onPressed});

  @override
  _VerifyCodeButtonState createState() => _VerifyCodeButtonState();
}

class _VerifyCodeButtonState extends State<VerifyCodeButton> {
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
                    MaterialPageRoute(builder: (context) => const NewPasswordPage()),
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
                'Verificar',
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
