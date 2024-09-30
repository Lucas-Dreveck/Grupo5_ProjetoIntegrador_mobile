import 'package:flutter/material.dart';

class RadioOptions extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  
  const RadioOptions({
    Key? key,
    this.options = const ['Conforme', 'Não Conforme', 'Não Aplicável'],
    this.selectedOption = '',
  }) : super(key: key);

  @override
  _RadioOptionsState createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {
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
          value: option,
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
