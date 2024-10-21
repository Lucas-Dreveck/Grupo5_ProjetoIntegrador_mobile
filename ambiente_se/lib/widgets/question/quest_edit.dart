import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/utils.dart';
import 'dart:convert';

class QuestionEditDialog extends StatefulWidget {
  final int id;

  const QuestionEditDialog({
    super.key,
    required this.id,
  });

  @override
  _QuestionEditDialogState createState() => _QuestionEditDialogState();
}

class _QuestionEditDialogState extends State<QuestionEditDialog> {
  TextEditingController questionController = TextEditingController();
  String? axis = 'Ambiental';
  String question = '';


  edit() async {
    final response = await makeHttpRequest('/api/auth/Question/${widget.id}', method: 'PUT', body: jsonEncode({
      'pillar': axis,
      'description': questionController.text,
    }));
    if (response.statusCode == 200) {
      AlertSnackBar.show(text: "Pergunta editada com sucesso.", backgroundColor: Colors.green, context: context);
      Navigator.of(context).pop();
    } else {
      AlertSnackBar.show(text: "Erro ao editar pergunta!", backgroundColor: Colors.red, context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  fetchQuestion() async {
    final response = await makeHttpRequest('/api/auth/Question/search/id/${widget.id}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> questionData = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        axis = questionData['pillar'];
        questionController.text = questionData['description'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar pergunta ${widget.id}', style: const TextStyle(fontSize: 20)),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Eixo da Pergunta',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButtonFormField<String>(
              value: axis,

              items: <String>['Ambiental', 'Social', 'Governamental']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  axis = newValue; // Atualiza o eixo selecionado
                });
              },
              decoration: InputDecoration(
                filled: true, // Preenche o fundo
                fillColor: const Color(0xFFD5E2E7), // Cor de fundo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  borderSide: BorderSide.none, // Remove a borda padrão
                ),
                hintText: 'Selecione um eixo',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pergunta',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: questionController,
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
          onPressed: edit,
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
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
