import 'package:ambiente_se/screens/login/nova_senha.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/screens/login/verificar_codigo.dart'; // Ensure this path is correct

class VerificarCodigoButton extends StatefulWidget {
  final Future<void> Function() onPressed;

  const VerificarCodigoButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _VerificarCodigoButtonState createState() => _VerificarCodigoButtonState();
}

class _VerificarCodigoButtonState extends State<VerificarCodigoButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
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
                    MaterialPageRoute(builder: (context) => const NovaSenhaPage()),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
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
