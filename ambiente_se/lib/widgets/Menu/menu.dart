import 'package:flutter/material.dart';
import 'package:ambiente_se/screens/ranking_empresa_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MenuLateral extends StatelessWidget {
  final Color customBlue = Color(0xFF0077C8);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: customBlue,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: customBlue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     Image.asset('assets/images/ambientese.png'),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.white),
                    title: Text('Ranking', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => RankingEmpresaPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.business, color: Colors.white),
                    title: Text('Empresas', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => EmpresaPage()),
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people, color: Colors.white),
                    title: Text('Funcionários', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Adicione a navegação para a página de Funcionários aqui
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer, color: Colors.white),
                    title: Text('Perguntas', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Adicione a navegação para a página de Perguntas aqui
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.assessment, color: Colors.white),
                    title: Text('Avaliação', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Adicione a navegação para a página de Avaliação aqui
                    },
                  ),
                  Divider(color: Colors.white),
                  ListTile(
                    leading: Icon(Icons.arrow_back, color: Colors.white),
                    title: Text('Voltar', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.exit_to_app, color: customBlue),
                label: Text('Sair', style: TextStyle(color: customBlue)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: customBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Adicione a lógica para sair do aplicativo aqui
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}