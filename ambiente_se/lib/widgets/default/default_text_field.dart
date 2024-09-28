import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DefaultTextField extends StatelessWidget {
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

  const DefaultTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.mask,
    this.initialValue = "",
    this.enabled = true,
    this.type = TextInputType.text,
    this.height = 40,
    this.fillColor = AppColors.ice,
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
              inputFormatters: mask != null ? [mask!] : [LengthLimitingTextInputFormatter(255)], 
              keyboardType: type,
              controller: controller,
              obscureText: obscureText,
              maxLength: 255,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                fillColor: fillColor,
                filled: true,
                counterText: '',
              ),
            ),
        ),
      ],
    );
  }
}
