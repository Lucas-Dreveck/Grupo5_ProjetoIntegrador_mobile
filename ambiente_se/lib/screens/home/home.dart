import 'package:ambiente_se/screens/company/main_company_page.dart';
import 'package:ambiente_se/screens/employee/main_employee_page.dart';
import 'package:ambiente_se/screens/evaluation/evaluation_page.dart';
import 'package:ambiente_se/screens/question/main_question_page.dart';
import 'package:ambiente_se/screens/ranking/ranking_page.dart';
import 'package:ambiente_se/widgets/home/build_menu_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                    title: 'Empresas',
                    onPressed: () {
                      // Navigate to company registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainCompanyPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Funcionários',
                    onPressed: () {
                      // Navigate to employee registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainEmployeePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Ranking',
                    onPressed: () {
                      // Navigate to ranking screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RankingEmpresaPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Perguntas',
                    onPressed: () {
                      // Navigate to questions screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MainQuestionPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30), // Consistent 40px padding
                  BuildMenuButton(
                    title: 'Avaliação',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EvaluationPage()),
                      );
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