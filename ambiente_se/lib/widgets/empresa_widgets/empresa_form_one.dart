import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_dropdown.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmpresaFormOne extends StatefulWidget {
  final TextEditingController nomeFantasiaController;
  final TextEditingController cnpjController;
  final TextEditingController razaoSocialController;
  final TextEditingController ramoController;
  final String porte;
  final ValueChanged<String> onPorteChanged;
  final bool isEditing;

  EmpresaFormOne({
    required this.nomeFantasiaController,
    required this.cnpjController,
    required this.razaoSocialController,
    required this.ramoController,
    required this.onPorteChanged,
    this.porte = "",
    this.isEditing = false,
  });

  @override
  _EmpresaFormOneState createState() => _EmpresaFormOneState();
}

class _EmpresaFormOneState extends State<EmpresaFormOne> {
  var porte;

  var mascaraCnpj = MaskTextInputFormatter(
    mask: '##.###.###/####-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  @override
  void initState() {
    super.initState();
    porte = widget.porte;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isEditing ? "Editar Empresa" : "Cadastro de Empresa",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Nome fantasia",
            hintText: "",
            controller: widget.nomeFantasiaController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "CNPJ",
            hintText: "",
            type: TextInputType.number,
            mask: mascaraCnpj,
            controller: widget.cnpjController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Razão Social",
            hintText: "",
            controller: widget.razaoSocialController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Ramo",
            hintText: "",
            controller: widget.ramoController,
          ),
          const SizedBox(height: 15),
          CadastroDropdown(
            items: ["Pequeno", "Médio", "Grande"],
            label: "Porte",
            initialValue: porte != "" ? porte : null,
            onChanged: (novoPorte) {
              setState(() {
                porte = novoPorte.toString();
              });
              widget.onPorteChanged(novoPorte.toString());
            },
          ),
        ],
      ),
    );
  }
}