import 'package:ambiente_se/widgets/home/build_menu_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function(int) onSelectPage;

  const Home({
    super.key,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Set background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  const Text(
                    'Bem Vindo, Lucas Dreveck',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Ranking',
                    onPressed: () {
                      // Navigate to company registration screen
                      onSelectPage(1);
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Empresas',
                    onPressed: () {
                      // Navigate to employee registration screen
                      onSelectPage(2);
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Funcionários',
                    onPressed: () {
                      // Navigate to ranking screen
                      onSelectPage(3);
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Perguntas',
                    onPressed: () {
                      // Navigate to questions screen
                      onSelectPage(4);
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Avaliação',
                    onPressed: () {
                      onSelectPage(5);
                      // Navigate to evaluation screen
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}