import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_dropdown.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmpresaFormThree extends StatefulWidget {
  final TextEditingController cepController;
  final TextEditingController cidadeController;
  final TextEditingController logradouroController;
  final TextEditingController bairroController;
  final TextEditingController complementoController;
  final ValueChanged<String> onUfChanged;
  final String uf;
  final bool isEditing;

  const EmpresaFormThree({
    required this.cepController,
    required this.cidadeController,
    required this.logradouroController,
    required this.bairroController,
    required this.complementoController,
    required this.uf,
    required this.onUfChanged,
    this.isEditing = false,
  });

  @override
  _EmpresaFormThreeState createState() => _EmpresaFormThreeState();
}

class _EmpresaFormThreeState extends State<EmpresaFormThree> {
  var uf;

  var mascaraCep = new MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static const List<String> ufsBrasil = [
    'AC', // Acre
    'AL', // Alagoas
    'AP', // Amapá
    'AM', // Amazonas
    'BA', // Bahia
    'CE', // Ceará
    'DF', // Distrito Federal
    'ES', // Espírito Santo
    'GO', // Goiás
    'MA', // Maranhão
    'MT', // Mato Grosso
    'MS', // Mato Grosso do Sul
    'MG', // Minas Gerais
    'PA', // Pará
    'PB', // Paraíba
    'PR', // Paraná
    'PE', // Pernambuco
    'PI', // Piauí
    'RJ', // Rio de Janeiro
    'RN', // Rio Grande do Norte
    'RS', // Rio Grande do Sul
    'RO', // Rondônia
    'RR', // Roraima
    'SC', // Santa Catarina
    'SP', // São Paulo
    'SE', // Sergipe
    'TO', // Tocantins
  ];

  @override
  void initState() {
    super.initState();
    uf = widget.uf;
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Cadastro de Empresa",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            type: TextInputType.number,
            mask: mascaraCep,
            label: "CEP",
            hintText: "",
            controller: widget.cepController,
          ),
          const SizedBox(height: 15),
          CadastroDropdown(
            items: ufsBrasil,
            label: "UF",
            initialValue: uf != "" ? uf : null,
            onChanged: (novoUF) {
              setState(() {
                uf = novoUF;
              });
              widget.onUfChanged(novoUF.toString());
            },
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Cidade",
            hintText: "",
            controller: widget.cidadeController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Logradouro",
            hintText: "",
            controller: widget.logradouroController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Bairro",
            hintText: "",
            controller: widget.bairroController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Complemento",
            hintText: "",
            controller: widget.complementoController,
          ),
        ]
      )
    );
  }
}