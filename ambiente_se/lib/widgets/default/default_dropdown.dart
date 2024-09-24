import 'package:flutter/material.dart';

class DefaultDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final Color fillColor;
  final double height;

  const DefaultDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.height = 40,
    this.fillColor = const Color(0xFFD5E2E7),
  });

  @override
  DefaultDropdownState<T> createState() => DefaultDropdownState<T>();
}

class DefaultDropdownState<T> extends State<DefaultDropdown<T>> {
  T? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.height,
          child: DropdownButtonFormField<T>(
            value: _currentValue,
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
                widget.onChanged(newValue);
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8), // Manter bordas arredondadas
                borderSide: BorderSide.none, // Remover a borda preta
              ),
              fillColor: widget.fillColor,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0), // Ajuste o preenchimento
            ),
            isExpanded:
                true, // Expande o dropdown para preencher o espaço disponível
            items: widget.items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                  overflow: TextOverflow
                      .ellipsis, // Adiciona reticências se o texto for muito longo
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
