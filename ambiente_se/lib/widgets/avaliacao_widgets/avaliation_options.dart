import 'package:flutter/material.dart';

class OpcoesRadio extends StatefulWidget {
  final List<String> opcoes;
  final String selectedOption;
  
  const OpcoesRadio({
    Key? key,
    this.opcoes = const ['Conforme', 'Não Conforme', 'Não Aplicável'],
    this.selectedOption = '',
  }) : super(key: key);

  @override
  _OpcoesRadioState createState() => _OpcoesRadioState();
}

class _OpcoesRadioState extends State<OpcoesRadio> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.opcoes.map((String opcao) {
        return RadioListTile<String>(
          title: Text(opcao),
          value: opcao,
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value;
            });
          },
        );
      }).toList(),
    );
  }
}
