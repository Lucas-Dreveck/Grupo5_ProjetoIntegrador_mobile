import 'package:ambiente_se/screens/company/main_company_page.dart';
import 'package:ambiente_se/widgets/home/build_menu_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Set background color
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0), // Set AppBar height
        child: AppBar(
          backgroundColor: const Color(0xFF0077C8), // Set AppBar color
          automaticallyImplyLeading: false, // Remove default leading widget
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 55,
                    color: Colors.white,
                    onPressed: () {
                      // Open drawer or navigation menu
                    },
                  ),
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: Image.asset(
                      'assets/images/logo_background_removed.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  const Text(
                    'Bem Vinde, Lucas Dreveck',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Cadastrar empresa',
                    onPressed: () {
                      // Navigate to company registration screen
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Cadastrar funcionário',
                    onPressed: () {
                      // Navigate to employee registration screen
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Visualizar ranking',
                    onPressed: () {
                      // Navigate to ranking screen
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Visualizar perguntas',
                    onPressed: () {
                      // Navigate to questions screen
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Avaliação',
                    onPressed: () {
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