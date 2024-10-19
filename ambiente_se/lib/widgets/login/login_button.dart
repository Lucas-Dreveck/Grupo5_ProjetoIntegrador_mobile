import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05; // Adjust font size based on screen width

    return SizedBox(
      height: 50, // Increase the height of the button
      width: screenWidth * 0.8, // Use 80% of the screen width
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 245, 245, 245),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0065A9),
          padding: const EdgeInsets.symmetric(vertical: 12), // Adjust padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}