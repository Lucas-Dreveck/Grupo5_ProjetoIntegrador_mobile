import 'dart:convert';

import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';

class QuestionRegistrationDialog extends StatefulWidget {
  const QuestionRegistrationDialog({super.key});

  @override
  _QuestionRegistrationDialogState createState() => _QuestionRegistrationDialogState();
}

class _QuestionRegistrationDialogState extends State<QuestionRegistrationDialog> {
  String? selectedAxis; 
  String question = ''; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cadastro de Pergunta'),
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
              value: selectedAxis,
              items: <String>['Ambiental', 'Social', 'Governamental']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAxis = newValue;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
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
              onChanged: (value) {
                setState(() {
                  question = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD5E2E7),
                hintText: 'Digite sua pergunta aqui....',
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
        ElevatedButton(
          onPressed: () {
            if (selectedAxis != null && question.isNotEmpty) {
              saveQuestion(selectedAxis!, question);
            } else {
              AlertSnackBar.show(text: "Por favor, preencha todos os campos.", backgroundColor: AppColors.red, context: context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
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
  
    void saveQuestion(String axis, String question) async {
      const url = '/api/auth/Question';
      final questionData = {
        'pillar': axis,
        'description': question,
      };
      try {
        final response = await makeHttpRequest(context, url, method: 'POST', body: jsonEncode(questionData));
        if (response.statusCode == 200) {
          AlertSnackBar.show(text: "Pergunta cadastrada com sucesso.", backgroundColor: AppColors.green, context: context);
          Navigator.of(context).pop();
        } else {
            AlertSnackBar.show(text: "Erro ao cadastrar pergunta!", backgroundColor: AppColors.red, context: context);          
        }
      } catch (e) {
            AlertSnackBar.show(text: "Erro ao cadastrar pergunta!", backgroundColor: AppColors.red, context: context);
      }
    }
  
}
