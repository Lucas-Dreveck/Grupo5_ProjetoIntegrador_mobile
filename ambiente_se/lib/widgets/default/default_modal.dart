import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:flutter/material.dart';

class DefaultModal extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final String labelButtonOne;
  final Color colorButtonOne;
  final String labelButtonTwo;
  final Color colorButtonTwo;

  const DefaultModal({
    super.key, 
    required this.text,
    required this.function,
    this.labelButtonOne = "Cancelar",
    this.colorButtonOne = AppColors.grey,
    this.labelButtonTwo = "Aceitar",
    this.colorButtonTwo = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.offWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
      ),
      contentPadding: const EdgeInsets.all(40), // Padding ao redor do conteúdo
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
              child: DefaultButton(
                label: labelButtonOne,
                color: colorButtonOne,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 16), // Espaçamento entre os botões
            Expanded(
              child: DefaultButton(
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