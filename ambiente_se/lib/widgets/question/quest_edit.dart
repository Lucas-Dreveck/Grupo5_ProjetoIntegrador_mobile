import 'package:flutter/material.dart';

class QuestionEditDialog extends StatelessWidget {
  final String axis; // Eixo da pergunta
  final String question; // Texto da pergunta

  const QuestionEditDialog({
    super.key,
    required this.axis,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController axisController = TextEditingController(text: axis);
    final TextEditingController questionController = TextEditingController(text: question);

    return AlertDialog(
      title: const Text('Editar Pergunta 1', style: TextStyle(fontSize: 20)),
      content: SizedBox(
        width: 300, // Largura do pop-up
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Eixo da Pergunta',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: axisController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7), // Cor de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pergunta',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: questionController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7), // Cor de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o pop-up
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey, // Cor do botão "Cancelar"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            // Lógica para salvar as alterações
            Navigator.of(context).pop(); // Fecha o pop-up
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green, // Cor do botão "Salvar"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Salvar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
