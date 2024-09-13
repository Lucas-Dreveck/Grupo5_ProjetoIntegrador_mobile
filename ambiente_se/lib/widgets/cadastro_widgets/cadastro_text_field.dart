import 'package:flutter/material.dart';

class CadastroTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color fillColor;
  final String label;
  final double height;


  const CadastroTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.height = 40,
    this.fillColor = const Color(0xFFD5E2E7),
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w800),),
        SizedBox(height: 8,),
        SizedBox(
          height: height,
          child: 
            TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: fillColor,
                filled: true,
              ),
            ),
        ),
      ],
    );
  }
}
