import 'package:ambiente_se/screens/evaluation/results_page.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final String companyName;
  final Map<String, List<EvaluationAnswer>> answers; // Agora usa um Map de respostas categorizadas
  final PageController pageController;
  final String label;

  const FinishButton({
    super.key,
    required this.companyName,
    required this.answers,
    required this.pageController,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: const Color.fromRGBO(2, 156, 111, 1.0),
      label: label, // Permite personalizar o rótulo do botão
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              companyName: companyName, // Passa o nome da empresa aqui
              categoryAnswers: answers, // Passa o Map de respostas categorizadas
            ),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
