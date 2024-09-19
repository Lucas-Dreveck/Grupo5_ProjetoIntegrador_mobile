import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/widgets/login_widgets/email_field.dart';
import 'package:ambiente_se/widgets/login_widgets/logo_widget.dart';
import 'package:ambiente_se/widgets/login_widgets/recuperar_senha_button.dart';
import 'package:ambiente_se/widgets/login_widgets/voltar_login.dart';
import 'package:ambiente_se/widgets/login_widgets/wave_painter.dart';
import 'package:flutter/material.dart';

class LoginRecuperarSenha extends StatefulWidget {
  const LoginRecuperarSenha({Key? key}) : super(key: key);

  @override
  _LoginRecuperarSenhaState createState() => _LoginRecuperarSenhaState();
}

class _LoginRecuperarSenhaState extends State<LoginRecuperarSenha> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _recuperarSenha() async {
    setState(() {
      if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
        _errorText = 'Please enter a valid email';
      } else {
        _errorText = null;
      }
    });

    if (_errorText == null) {
      // Simulate async operation
      await Future.delayed(const Duration(seconds: 2));
      // TODO: Implement recuperar senha logic
      print('Email: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    'RECUPERE A SUA SENHA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                  const SizedBox(height: 22),
                  EmailField(controller: _emailController, errorText: _errorText),
                  const SizedBox(height: 60),
                  RecuperarSenhaButton(
                    onPressed: _recuperarSenha,
                  ),
                  const SizedBox(height: 14),
                  VoltarLogin(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
