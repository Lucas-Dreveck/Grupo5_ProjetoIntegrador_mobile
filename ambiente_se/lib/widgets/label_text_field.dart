import 'package:ambiente_se/widgets/custom_text_field.dart';
import 'package:ambiente_se/widgets/text_label.dart';
import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController controller;
  final double fontSize;
  final Color color;

  const LabelTextField({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
    this.fontSize = 16,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextLabel(text: text,),
        CustomTextField(hintText: hintText, controller: controller),
      ],
    );

  }
}
