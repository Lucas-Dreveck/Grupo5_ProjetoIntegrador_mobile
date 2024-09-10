import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const TextLabel({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
