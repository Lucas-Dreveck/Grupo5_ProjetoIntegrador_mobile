import 'package:ambiente_se/widgets/CustomTextField.dart';
import 'package:ambiente_se/widgets/TextLabel.dart';
import 'package:flutter/material.dart';

class CadastroEmpresaPage extends StatefulWidget {
  const CadastroEmpresaPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroEmpresaPage> createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage>{

  TextEditingController _nomeFantasiaController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
              TextLabel(text: "Nome fantasia"),
              CustomTextField(hintText: "", controller: _nomeFantasiaController)
          ],
        ),
      ),
      
    );
  }
}