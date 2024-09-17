import 'package:flutter/material.dart';

class CadastroSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String hintText;

  const CadastroSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.hintText = 'Pesquisar...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
       // Margens externas
      padding: EdgeInsets.symmetric(horizontal: 8), // Padding interno
      decoration: BoxDecoration(
        color: Color(0xFFD5E2E7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 8), // Espaçamento entre o ícone e o campo de texto
          Expanded(
            child: Center(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0), // Ajuste do padding vertical
                ),
                onSubmitted: (_) => onSearch(), // Executa a busca ao submeter
              ),
            ),
          ),
        ],
      ),
    );
  }
}
