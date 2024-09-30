import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final PageController pageController;
  final String label;
  final Color color;
  final double width;
  final double height;

  const NextPageButton({
    Key? key,
    required this.pageController,
    this.label = 'Próxima',
    this.color = Colors.blue,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: label,
      onPressed: () {
        pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      width: width,
      height: height,
    );
  }
}
