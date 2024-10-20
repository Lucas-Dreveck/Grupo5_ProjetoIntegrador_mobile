import 'package:flutter/material.dart';

class QuestionRegistrationDialog extends StatefulWidget {
  const QuestionRegistrationDialog({super.key});

  @override
  _QuestionRegistrationDialogState createState() => _QuestionRegistrationDialogState();
}

class _QuestionRegistrationDialogState extends State<QuestionRegistrationDialog> {
  String? selectedAxis; // Variável para armazenar o eixo selecionado
  String question = ''; // Variável para armazenar a pergunta

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cadastro de Pergunta'),
      content: SizedBox(
        width: 300, // Largura do pop-up
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
                  selectedAxis = newValue; // Atualiza o eixo selecionado
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
              onChanged: (value) {
                setState(() {
                  question = value; // Atualiza a pergunta
                });
              },
              decoration: InputDecoration(
                filled: true, // Preenche o fundo
                fillColor: const Color(0xFFD5E2E7), // Cor de fundo
                hintText: 'Digite sua pergunta aqui....',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  borderSide: BorderSide.none, // Remove a borda padrão
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
            backgroundColor: Colors.grey, // Cor de fundo do botão "Cancelar"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordas arredondadas
            ),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white), // Cor do texto
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica para salvar a pergunta
            Navigator.of(context).pop(); // Fecha o pop-up após salvar
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Cor de fundo do botão "Salvar"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bordas arredondadas
            ),
          ),
          child: const Text(
            'Salvar',
            style: TextStyle(color: Colors.white), // Cor do texto
          ),
        ),
      ],
    );
  }
}