import 'package:ambiente_se/widgets/default/default_dropdown.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmployeeForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController birthDateController;
  final String role;
  final ValueChanged<String> onroleChanged;
  final TextEditingController emailController;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool isEditing;

  const EmployeeForm({
    required Key key,
    required this.nameController,
    required this.cpfController,
    required this.birthDateController,
    required this.onroleChanged,
    this.role = "",
    required this.emailController,
    required this.loginController,
    required this.passwordController,
    this.isEditing = false,
  }) : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  late String role;
  late bool isEditing;

  var maskCpf = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskDate = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    role = widget.role;
    isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isEditing ? "Editar Funcionário" : "Cadastro de Funcionário",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Nome",
            hintText: "",
            controller: widget.nameController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "CPF",
            hintText: "",
            type: TextInputType.number,
            mask: maskCpf,
            controller: widget.cpfController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Data de Nascimento",
            hintText: "",
            mask: maskDate,
            controller: widget.birthDateController,
          ),
          const SizedBox(height: 15),
          DefaultDropdown(
            key: UniqueKey(),
            items: const ["Gestor", "Consultor"],
            label: "Cargo",
            initialValue: role != "" ? role : null,
            onChanged: (newrole) {
              setState(() {
                role = newrole.toString();
              });
              widget.onroleChanged(newrole.toString());
            },
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Email",
            type: TextInputType.emailAddress,
            hintText: "",
            controller: widget.emailController,
          ),
          if (!widget.isEditing) ...[
            const SizedBox(height: 15),
            DefaultTextField(
              label: "Login",
              hintText: "",
              controller: widget.loginController,
            ),
            const SizedBox(height: 15),
            DefaultTextField(
              label: "Senha",
              hintText: "",
              controller: widget.passwordController,
            ),
          ],
        ],
      ),
    );
  }
}
