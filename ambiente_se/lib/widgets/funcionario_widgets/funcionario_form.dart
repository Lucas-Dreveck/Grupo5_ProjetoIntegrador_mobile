import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_dropdown.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FuncionarioForm extends StatefulWidget {
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController dataNascimentoController;
  final String cargo;
  final ValueChanged<String> onCargoChanged;
  final TextEditingController emailController;
  final TextEditingController loginController;
  final TextEditingController senhaController;
  final bool isEditing;

  FuncionarioForm({
    required this.nomeController,
    required this.cpfController,
    required this.dataNascimentoController,
    required this.onCargoChanged,
    this.cargo = "",
    required this.emailController,
    required this.loginController,
    required this.senhaController,
    this.isEditing = false,
  });

  @override
  _FuncionarioFormState createState() => _FuncionarioFormState();
}

class _FuncionarioFormState extends State<FuncionarioForm> {
  var cargo;

  var mascaraCpf = MaskTextInputFormatter(
    mask: '###.###.###-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  var mascaraData = MaskTextInputFormatter(
    mask: '##/##/####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  @override
  void initState() {
    super.initState();
    cargo = widget.cargo;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isEditing ? "Editar Funcionário" : "Cadastro de Funcionário",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Nome",
            hintText: "",
            controller: widget.nomeController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "CPF",
            hintText: "", 
            type: TextInputType.number,
            mask: mascaraCpf,
            controller: widget.cpfController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Data de Nascimento",
            hintText: "",
            mask: mascaraData,
            controller: widget.dataNascimentoController,
          ),
          const SizedBox(height: 15),
          CadastroDropdown(
            items: ["Gestor", "Consultor"],
            label: "Cargo",
            initialValue: cargo != "" ? cargo : null,
            onChanged: (novoCargo) {
              setState(() {
                cargo = novoCargo.toString();
              });
              widget.onCargoChanged(novoCargo.toString());
            },
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Email",
            type: TextInputType.emailAddress,
            hintText: "",
            controller: widget.emailController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Login",
            hintText: "",
            controller: widget.loginController,
          ),
          const SizedBox(height: 15),
          CadastroTextField(
            label: "Senha",
            hintText: "",
            controller: widget.senhaController,
          ),
        ],
      ),
    );
  }
}