import 'package:ambiente_se/widgets/evaluation/evaluation_options.dart';
import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String question;
  final String selectedOption;
  final ValueChanged<String> onSelected; // Callback para enviar a resposta selecionada

  const Questions({
    super.key,
    required this.question,
    required this.onSelected,
    this.selectedOption = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          EvaluationOptions(
            onSelected: onSelected, // Passa o callback para o EvaluationOptions
            selectedOption: selectedOption, // Passa a opção selecionada
          ),
        ],
      ),
    );
  }
}
