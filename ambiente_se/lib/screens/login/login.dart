import 'package:ambiente_se/screens/home/home.dart';
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
import 'package:http/http.dart' as http;
import 'package:ambiente_se/utils.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(); 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            content: const Text('Por favor insira email e senha.'),
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

    // Create the body to send to the backend
    Map<String, String> loginData = {
      "login": email,
      "password": password,
    };

    try {
      // Send POST request to the backend to log in
      final response = await makeHttpRequest('/api/login', method: 'POST', body: jsonEncode(loginData));

      if (response.statusCode == 200) {
        // Successfully logged in, extract the token
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        String token = responseBody['token'];

        // Store the token securely
        await _secureStorage.write(key: 'auth_token', value: token);

        // Navigate to the Home screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        // Handle error, show message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erro ao realizar login.'),
              content: const Text('Email ou senha invalidos.'),
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
      }
    } catch (error) {
      // Handle any errors during the request
      print('Erro ao realizar login: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Erro ao realizar login.'),
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
    }
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
                    'ACESSE A SUA CONTA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                  const SizedBox(height: 22),
                  EmailField(
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 60),
                  LoginButton(
                    onPressed: _login, // Call the _login method on button press
                  ),
                  const SizedBox(height: 14),
                  ForgotPassword(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginRecoverPassword()),
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
