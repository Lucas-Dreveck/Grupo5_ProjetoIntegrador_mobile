import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/question/quest_delete.dart';
import 'package:ambiente_se/widgets/question/quest_edit.dart';
import 'dart:convert';

class QuestionDetailDialog extends StatefulWidget {
  final int id;

  const QuestionDetailDialog({
    super.key,
    required this.id,
  });

  @override
  _QuestionDetailDialogState createState() => _QuestionDetailDialogState();
}

class _QuestionDetailDialogState extends State<QuestionDetailDialog> {
  String axis = 'Ambiental';
  String question = '';

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
      title: Text('Pergunta ${widget.id}', style: const TextStyle(fontSize: 20)),
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
            'Voltar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
              return QuestionEditDialog(
                id: widget.id,
              );
              }
            ).then((_) {
              fetchQuestion();
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
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
            showDialog(
              context: context,
              builder: (context) => QuestionDeleteDialog(
                id: widget.id,
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
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
