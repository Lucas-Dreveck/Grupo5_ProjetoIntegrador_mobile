import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/custom_app_bar.dart';

class RankingEmpresaPage extends StatefulWidget {
  final String title;

  const RankingEmpresaPage({super.key, required this.title});

  @override
  State<RankingEmpresaPage> createState() => _RankingEmpresaPage();
}

class _RankingEmpresaPage extends State<RankingEmpresaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),  // Usa o título passado ao criar a página
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Buscar por nome da empresa',
          ),
        ),

      




      ),
    );
  }
}
