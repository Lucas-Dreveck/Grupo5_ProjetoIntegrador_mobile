import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/question_widgets/quest_delete.dart'; 
import 'package:ambiente_se/widgets/question_widgets/quest_edit.dart';

class QuestionDetailDialog extends StatelessWidget {
  final String axis; // Eixo da pergunta
  final String question; // Texto da pergunta
  final VoidCallback onDelete; // Função de callback para exclusão

  const QuestionDetailDialog({
    Key? key,
    required this.axis,
    required this.question,
    required this.onDelete, // Adiciona o parâmetro de exclusão
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pergunta 1', style: TextStyle(fontSize: 20)),
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
              controller: TextEditingController(text: axis),
              readOnly: true, // Torna o campo somente leitura
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
              controller: TextEditingController(text: question),
              readOnly: true, // Torna o campo somente leitura
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7), // Cor de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
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
            // Chama o modal de edição ao pressionar "Editar"
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return QuestionEditDialog(
                  axis: axis, // Passa o eixo da pergunta
                  question: question, // Passa a pergunta
                );
              },
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue, // Cor do botão "Editar"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            // Chame o QuestionDeleteDialog aqui
            showDialog(
              context: context,
              builder: (context) => QuestionDeleteDialog(
                axis: axis, // Passa o eixo da pergunta
                question: question, // Passa a pergunta
                onDelete: () {
                  // Lógica para exclusão
                },
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Cor do botão "Excluir"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Excluir',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
