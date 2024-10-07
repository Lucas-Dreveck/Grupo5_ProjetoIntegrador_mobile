import 'package:ambiente_se/screens/evaluation/results_page.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/evaluation_answer.dart';
import 'package:flutter/material.dart';
class FinishButton extends StatelessWidget {
  final String companyName;
  final List<EvaluationAnswer> answers; // Adiciona uma lista de respostas

  const FinishButton({Key? key, required this.companyName, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: const Color.fromRGBO(2, 156, 111, 1.0),
      label: 'Finalizar',
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              companyName: companyName, // Passa o nome da empresa aqui
              answers: answers, // Passa as respostas selecionadas
            ),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
