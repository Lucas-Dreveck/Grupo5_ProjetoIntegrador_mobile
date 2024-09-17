
import 'package:flutter/material.dart';

class CadastroBuscarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  const CadastroBuscarButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFFD5E2E7),
    this.height = 35,
  });

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
        child: FittedBox(
          fit: BoxFit.scaleDown, // Reduz o texto para caber no botão
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis, // Adiciona "..." caso o texto seja muito longo
          ),
        ),
      ),
    );
  }
}
