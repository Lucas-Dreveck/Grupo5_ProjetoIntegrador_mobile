import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final PageController pageController;
  final Future<void> Function()? sendQuestions;
  final String label;
  final Color color;
  final double width;
  final double height;

  const NextPageButton({
    super.key,
    required this.pageController,
    this.sendQuestions,
    this.label = 'Próxima',
    this.color = Colors.blue,
    this.width = 200,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: label,
      onPressed: () {
        if (sendQuestions != null) {
          sendQuestions!().then((_) {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      width: width,
      height: height,
    );
  }
}
