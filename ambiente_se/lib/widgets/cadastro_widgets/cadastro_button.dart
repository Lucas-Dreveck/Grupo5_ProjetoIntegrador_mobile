import 'package:flutter/material.dart';

class CadastroButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  const CadastroButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFF0077C8),
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Controla o borderRadius
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
