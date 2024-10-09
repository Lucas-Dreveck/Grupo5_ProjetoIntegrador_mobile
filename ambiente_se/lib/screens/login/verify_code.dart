import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/widgets/login_widgets/logo_widget.dart';
import 'package:ambiente_se/widgets/login_widgets/verificar_codigo_button.dart';
import 'package:ambiente_se/widgets/login_widgets/verification_code.dart';
import 'package:ambiente_se/widgets/login_widgets/back_to_login.dart';
import 'package:ambiente_se/widgets/login_widgets/wave_painter.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _VerifyCode() async {
    setState(() {
      if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
        _errorText = 'Por favor, insira um email válido.';
      } else {
        _errorText = null;
      }
    });

    if (_errorText == null) {
      await Future.delayed(const Duration(seconds: 2));
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
                    'VERIFICAÇÃO DE CÓDIGO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const VerificationCodeField(),
                  const SizedBox(height: 60),
                  VerifyCodeButton(
                    onPressed: _VerifyCode,
                  ),
                  const SizedBox(height: 14),
                  BackToLogin(
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