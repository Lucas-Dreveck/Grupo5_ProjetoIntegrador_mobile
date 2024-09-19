import 'package:flutter/material.dart';

class CadastrarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  const CadastrarButton({
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
            borderRadius: BorderRadius.circular(13), 
          ),
          padding: EdgeInsets.all(8.0),// Controla o borderRadius

        ),
        child:
        Row(
          children: [
             Container(
              padding: EdgeInsets.all(4), // Espaçamento dentro do círculo
              decoration: BoxDecoration(
                color: Colors.white, // Cor de fundo do círculo
                shape: BoxShape.circle, // Forma de círculo
              ),
              child: Icon(
                Icons.add,
                color: Colors.black, // Cor do ícone
                size: 12, // Tamanho do ícone
              ),
            ),
            SizedBox(width: 8), // Espaçamento entre o ícone e o texto
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
