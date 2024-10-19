import 'package:flutter/material.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/widgets/Menu/menu.dart';
import 'package:ambiente_se/screens/home/home.dart';
import 'package:ambiente_se/screens/ranking/ranking_page.dart';
import 'package:ambiente_se/screens/company/main_company_page.dart';
import 'package:ambiente_se/screens/employee/main_employee_page.dart';
import 'package:ambiente_se/screens/question/main_question_page.dart';
import 'package:ambiente_se/screens/evaluation/evaluation_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Ambiente SE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomMenuIcon extends StatelessWidget {
  const CustomMenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35, // Largura das barras do menu
      height: 30, // Altura total do ícone
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Controla o espaçamento entre as barras
        children: <Widget>[
          Container(
            height: 3, // Altura de cada barra
            color: Colors.white, // Cor da barra
          ),
          Container(
            height: 3,
            color: Colors.white,
          ),
          Container(
            height: 3,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const RankingEmpresaPage(),
    const MainCompanyPage(),
    const MainEmployeePage(),
    const MainQuestionPage(),
    const EvaluationPage(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(85), // Define a altura da AppBar para 85px
          child: Container(
            height: 85, // Altura da AppBar
            color: AppColors.blue, // Cor de fundo da AppBar
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const CustomMenuIcon(),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Image.asset(
                      'assets/images/logo_background_removed.png',
                      height: 75,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: MenuLateral(
          selectedPageIndex: _selectedPageIndex,
          onSelectPage: _selectPage,
        ),
        body: _pages[_selectedPageIndex],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}