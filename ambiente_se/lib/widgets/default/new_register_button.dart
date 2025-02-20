import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';

class NewRegisterButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  const NewRegisterButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.ice,
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
            borderRadius: BorderRadius.circular(13), 
          ),
          padding: const EdgeInsets.all(8.0),// Controla o borderRadius

        ),
        child:
        Row(
          children: [
             Container(
              padding: const EdgeInsets.all(4), // Espaçamento dentro do círculo
              decoration: const BoxDecoration(
                color: Colors.white, // Cor de fundo do círculo
                shape: BoxShape.circle, // Forma de círculo
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black, // Cor do ícone
                size: 12, // Tamanho do ícone
              ),
            ),
            const SizedBox(width: 8), // Espaçamento entre o ícone e o texto
            FittedBox(
              fit: BoxFit.scaleDown, // Reduz o texto para caber no botão
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis, // Adiciona "..." caso o texto seja muito longo
              ),
            ),
          ]
        ),
      ),
    );
  }
}
