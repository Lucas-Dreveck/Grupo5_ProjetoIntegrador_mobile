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
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late List<Widget> _pages;
  final List<int> _navigationStack = [0];

  @override
  void initState() {
    super.initState();
    _pages = [
      Home(onSelectPage: _selectPage),
      const RankingPage(),
      const MainCompanyPage(),
      const MainEmployeePage(),
      const MainQuestionPage(),
      EvaluationPage(onSelectPage: _selectPage),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      if (_navigationStack.last != index) {
        _navigationStack.add(index);
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
      });
      return false;
    } else {
      return (await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Você gostaria de sair do aplicativo?'),
              actions: [
                TextButton(
                  child: const Text('Não'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Sim'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Container(
            height: 85,
            color: AppColors.blue,
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
          selectedPageIndex: _navigationStack.last,
          onSelectPage: _selectPage,
        ),
        body: _pages[_navigationStack.last],
      ),
    );
  }
}

class CustomMenuIcon extends StatelessWidget {
  const CustomMenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 3,
            color: Colors.white,
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