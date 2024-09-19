import 'package:ambiente_se/widgets/login_widgets/email_field.dart';
import 'package:ambiente_se/widgets/login_widgets/forgot_password.dart';
import 'package:ambiente_se/widgets/login_widgets/login_button.dart';
import 'package:ambiente_se/widgets/login_widgets/logo_widget.dart';
import 'package:ambiente_se/widgets/login_widgets/password_field.dart';
import 'package:ambiente_se/widgets/login_widgets/wave_painter.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White overlay with wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: WavePainter(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.73,
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 6),
                  const Text(
                    'BEM-VINDO',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 20, 20),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ACESSE A SUA CONTA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const EmailField(),
                  const SizedBox(height: 20),
                  const PasswordField(),
                  const SizedBox(height: 60),
                  LoginButton(
                    onPressed: () {
                      // TODO: Implement login logic
                    },
                  ),
                  const SizedBox(height: 14),
                  ForgotPassword(
                    onPressed: () {
                      // TODO: Implement forgot password logic
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
