import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/utils.dart';
import 'dart:convert';

class QuestionDeleteDialog extends StatefulWidget {
  final int id;

  const QuestionDeleteDialog({
    super.key,
    required this.id,
  });

  @override
  _QuestionDeleteDialogState createState() => _QuestionDeleteDialogState();
}

class _QuestionDeleteDialogState extends State<QuestionDeleteDialog> {
  String axis = '';
  String question = '';

  delete() async {
  try {
        final response = await makeHttpRequest(context, '/api/auth/Question/${widget.id}', method: 'DELETE');
        print(response.statusCode);
        if (response.statusCode == 204) {
        AlertSnackBar.show(text: "Pergunta excluída com sucesso.", backgroundColor: AppColors.green, context: context);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        } else {
          AlertSnackBar.show(text: "Erro ao excluir pergunta!", backgroundColor: AppColors.red, context: context);
        }
      } catch (e) {
        AlertSnackBar.show(text: "Não é possível excluir, pergunta em uso!", backgroundColor: AppColors.red, context: context);
      }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  fetchQuestion() async {
    final response = await makeHttpRequest(context, '/api/auth/Question/search/id/${widget.id}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> questionData = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        axis = questionData['pillar'];
        question = questionData['description'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar exclusão de pergunta ${widget.id}', style: const TextStyle(fontSize: 20)),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Eixo da Pergunta',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: TextEditingController(text: axis),
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7),
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
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7),
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
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
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
          onPressed: delete,
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Confirmar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
