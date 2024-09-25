import 'package:ambiente_se/screens/resultados2_page.dart';
import 'package:ambiente_se/screens/resultados_page.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {

  const FinishButton({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Color.fromRGBO(2, 156, 111, 1.0),
      label: 'Finalizar',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultadosPage()),
        );
      },
    );
  }
}
