import 'package:flutter/material.dart';
class EvaluationOptions extends StatefulWidget {
  final List<String> options;
  final List<String> optionsValue;
  final String selectedOption;
  final ValueChanged<String>? onSelected; // Adiciona um callback

  const EvaluationOptions({
    super.key,
    this.options = const ['Conforme', 'Não Conforme', 'Não Aplicável'],
    this.optionsValue = const ['Conforme', 'NaoConforme', 'NaoSeAdequa'],
    this.selectedOption = '',
    this.onSelected, // Inicializa o callback
  });

  @override
  _EvaluationOptionsState createState() => _EvaluationOptionsState();
}

class _EvaluationOptionsState extends State<EvaluationOptions> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((String option) {
        return RadioListTile<String>(
          title: Text(option),
          value: widget.optionsValue[widget.options.indexOf(option)],
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value;
            });
            widget.onSelected?.call(value!); // Chama o callback quando o valor muda
          },
        );
      }).toList(),
    );
  }
}
