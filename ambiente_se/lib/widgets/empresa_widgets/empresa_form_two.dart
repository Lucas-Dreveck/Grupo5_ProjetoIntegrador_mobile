import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmpresaFormTwo extends StatefulWidget {
  final TextEditingController nomeSolicitanteController;
  final TextEditingController telefoneSolicitanteController;
  final TextEditingController emailEmpresaController;
  final TextEditingController telefoneEmpresaController;
  final bool isEditing;

  const EmpresaFormTwo({
    required this.nomeSolicitanteController,
    required this.telefoneSolicitanteController,
    required this.emailEmpresaController,
    required this.telefoneEmpresaController,
    this.isEditing = false,
  });

  @override
  _EmpresaFormTwoState createState() => _EmpresaFormTwoState();
}

class _EmpresaFormTwoState extends State<EmpresaFormTwo> {

  var mascaraTelefone = new MaskTextInputFormatter(
    mask: '+## (##)#####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );


  
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
            label: "Nome do solicitante",
            hintText: "",
            controller: widget.nomeSolicitanteController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Telefone do solicitante",
            type: TextInputType.number,
            hintText: "",
            controller: widget.telefoneSolicitanteController,
            mask: mascaraTelefone,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Email da empresa",
            type: TextInputType.emailAddress,
            hintText: "",
            controller: widget.emailEmpresaController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Telefone da empresa",
            type: TextInputType.number,
            hintText: "",
            controller: widget.telefoneEmpresaController,
            mask: mascaraTelefone,
          ), 
        ]
      ),
    );
  }
}