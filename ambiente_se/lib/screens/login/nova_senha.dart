import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/widgets/login_widgets/confirm_password_field.dart';
import 'package:ambiente_se/widgets/login_widgets/definir_senha_button.dart';
import 'package:ambiente_se/widgets/login_widgets/logo_widget.dart';
import 'package:ambiente_se/widgets/login_widgets/new_password_field.dart';
import 'package:ambiente_se/widgets/login_widgets/voltar_login.dart';
import 'package:ambiente_se/widgets/login_widgets/wave_painter.dart';
import 'package:flutter/material.dart';

class NovaSenhaPage extends StatefulWidget {
  const NovaSenhaPage({Key? key}) : super(key: key);

  @override
  _NovaSenhaPageState createState() => _NovaSenhaPageState();
}

class _NovaSenhaPageState extends State<NovaSenhaPage> {
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
                  DefinirSenhaButton(
                    onPressed: () async {
                      // TODO: Implement login logic
                    },
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