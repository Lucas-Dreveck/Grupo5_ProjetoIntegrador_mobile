import 'package:ambiente_se/screens/evaluation/results_page.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final String companyName; // Adiciona um parâmetro para o nome da empresa

  const FinishButton({Key? key, required this.companyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: const Color.fromRGBO(2, 156, 111, 1.0),
      label: 'Finalizar',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              companyName: companyName, // Passa o nome da empresa aqui
            ),
          ),
        );
      },
    );
  }
}
