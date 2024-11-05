import 'package:ambiente_se/main.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/login/forgot_password.dart';
import 'package:ambiente_se/widgets/login/login_button.dart';
import 'package:ambiente_se/widgets/login/logo_widget.dart';
import 'package:ambiente_se/widgets/login/email_field.dart';
import 'package:ambiente_se/widgets/login/password_field.dart';
import 'package:ambiente_se/widgets/login/wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/screens/login/login_recover_password.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:ambiente_se/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkLogin() async {
    String? token = await _secureStorage.read(key: 'auth_token');
    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainApp()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor insira seu usuário ou email e senha.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, String> loginData = {
      "login": email,
      "password": password,
    };

    try {
      final response = await makeHttpRequest(context, '/api/login', method: 'POST', body: jsonEncode(loginData));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        String token = responseBody['token'];

        await _secureStorage.write(key: 'auth_token', value: token);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainApp()),
          (Route<dynamic> route) => false,
        );
      } else {
        AlertSnackBar.show(
          context: context,
          text: 'Erro ao realizar login.',
          backgroundColor: const Color.fromARGB(255, 215, 90, 98),
        );
      }
    } catch (error) {
      AlertSnackBar.show(
        context: context,
        text: 'Erro ao realizar login.',
        backgroundColor: const Color.fromARGB(255, 215, 90, 98),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents resizing when keyboard appears
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
                height: MediaQuery.of(context).size.height * 0.8,
              ),
            ),
          ),
          Center(
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
                SingleChildScrollView( // Wrap only the form fields
                  child: Column(
                    children: [
                      EmailField(
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 60),
                      LoginButton(
                        onPressed: _login,
                      ),
                      const SizedBox(height: 14),
                      ForgotPassword(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginRecoverPassword()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}