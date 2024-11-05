import 'package:ambiente_se/screens/login/login.dart';
import 'package:flutter/material.dart';

class SetPasswordButton extends StatefulWidget {
  final Future<void> Function() onPressed;

  const SetPasswordButton({super.key, required this.onPressed});

  @override
  _SetPasswordButtonState createState() => _SetPasswordButtonState();
}

class _SetPasswordButtonState extends State<SetPasswordButton> {
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
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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
                'Definir senha',
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
