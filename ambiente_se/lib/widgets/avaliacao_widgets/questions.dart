import 'package:ambiente_se/widgets/avaliacao_widgets/avaliation_options.dart';
import 'package:flutter/material.dart';

class PerguntaComOpcoes extends StatelessWidget {
  final String pergunta;

  const PerguntaComOpcoes({Key? key, required this.pergunta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pergunta,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          OpcoesRadio(), // Widget de opções de rádio para responder à pergunta
        ],
      ),
    );
  }
}
