import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/widgets/login/confirm_password_field.dart';
import 'package:ambiente_se/widgets/login/set_password_button.dart';
import 'package:ambiente_se/widgets/login/logo_widget.dart';
import 'package:ambiente_se/widgets/login/new_password_field.dart';
import 'package:ambiente_se/widgets/login/back_to_login.dart';
import 'package:ambiente_se/widgets/login/wave_painter.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
                    'DEFINA SUA NOVA SENHA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const NewPasswordField(),
                  const SizedBox(height: 20),
                  const ConfirmPasswordField(),
                  const SizedBox(height: 60),
                  SetPasswordButton(
                    onPressed: () async {
                    },
                  ),
                  const SizedBox(height: 14),
                  BackToLogin(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
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