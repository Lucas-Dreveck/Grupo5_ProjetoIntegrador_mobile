import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PreviousPageButton extends StatelessWidget {
  final PageController pageController;

  const PreviousPageButton({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Anterior',
      onPressed: () {
        pageController.previousPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}
