import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color fillColor;
  final String label;
  final double height;
  final TextInputType type; 
  final MaskTextInputFormatter? mask;
  final String initialValue;
  final bool enabled;

  const CadastroTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.mask,
    this.initialValue = "",
    this.enabled = true,
    this.type = TextInputType.text,
    this.height = 40,
    this.fillColor = const Color(0xFFD5E2E7),
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800),),
        const SizedBox(height: 8,),
        SizedBox(
          height: height,
          child: 
            TextField(
              enabled: enabled,
              inputFormatters: mask != null ? [mask!] : [],
              keyboardType: type,
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                fillColor: fillColor,
                filled: true,
              ),
            ),
        ),
      ],
    );
  }
}
