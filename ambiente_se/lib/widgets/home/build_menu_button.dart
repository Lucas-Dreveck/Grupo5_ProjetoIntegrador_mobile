import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';

class BuildMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BuildMenuButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 300,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}