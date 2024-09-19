import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:flutter/material.dart';

class CadastroModal extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final String labelButtonOne;
  final Color colorButtonOne;
  final String labelButtonTwo;
  final Color colorButtonTwo;

  const CadastroModal({
    required this.text,
    required this.function,
    this.labelButtonOne = "Cancelar",
    this.colorButtonOne = const Color(0xff838B91),
    this.labelButtonTwo = "Aceitar",
    this.colorButtonTwo = const Color(0xFF0077C8),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffFCFCFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
      ),
      contentPadding: EdgeInsets.all(40), // Padding ao redor do conteúdo
      contentTextStyle: const TextStyle(
        color: Colors.black, // Cor do texto do conteúdo
        fontSize: 18, 
      ),
      content: Text(text, textAlign: TextAlign.center),      
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CadastroButton(
                label: labelButtonOne,
                color: colorButtonOne,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(width: 16), // Espaçamento entre os botões
            Expanded(
              child: CadastroButton(
                label: labelButtonTwo,
                color: colorButtonTwo,
                onPressed: () {
                  function();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}