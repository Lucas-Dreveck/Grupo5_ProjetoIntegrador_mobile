import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final PageController pageController;

  const FinishButton({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Color.fromRGBO(2, 156, 111, 1.0),
      label: 'Finalizar',
      onPressed: () {
        pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}
