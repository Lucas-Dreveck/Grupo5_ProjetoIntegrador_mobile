import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ambiente_se/screens/ranking_empresa_page.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF0077C8),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: SvgPicture.asset(
                'assets/Vector.svg',
                height: 60, // Ajuste conforme necessário
                color: Colors.white, // Opcional: para colorir o SVG
              ),
            ),
            ListTile(
              leading: Icon(Icons.business, color: Colors.white),
              title: Text('Empresas', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navegação para a página de Empresas
                Navigator.pop(context);
                // Adicione a navegação para a página de Empresas aqui
              },
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.white),
              title: Text('Funcionários', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navegação para a página de Funcionários
                Navigator.pop(context);
                // Adicione a navegação para a página de Funcionários aqui
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.white),
              title: Text('Perguntas', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navegação para a página de Perguntas
                Navigator.pop(context);
                // Adicione a navegação para a página de Perguntas aqui
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.white),
              title: Text('Ranking', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankingEmpresaPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assessment, color: Colors.white),
              title: Text('Avaliação', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navegação para a página de Avaliação
                Navigator.pop(context);
                // Adicione a navegação para a página de Avaliação aqui
              },
            ),
            Divider(color: Colors.white),
            ListTile(
              leading: Icon(Icons.arrow_back, color: Colors.white),
              title: Text('Voltar', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
