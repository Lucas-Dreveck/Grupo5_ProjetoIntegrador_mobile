import 'package:flutter/material.dart';

// Criação de um componente botão reutilizável
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final double width;
  final double height;

  // Construtor do componente, permitindo a personalização através dos parâmetros
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Alterado de 'primary' para 'backgroundColor'
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
