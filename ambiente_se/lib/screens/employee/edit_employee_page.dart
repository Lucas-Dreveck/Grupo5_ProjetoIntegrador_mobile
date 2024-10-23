import 'dart:convert';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/employee/employee_form.dart';
import 'package:flutter/material.dart';

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({super.key, required this.id});

  final int id;

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  late int id;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  var _role = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _updaterole(String newrole) {
    setState(() {
      _role = newrole;
    });
  }

  bool verifyPage() {
    if (_nameController.text.isEmpty) {
      AlertSnackBar.show(
        context: context,
        text: "O campo de nome não pode estar vazio.",
      );
      return false;
    }
    if (_cpfController.text.isEmpty) {
      AlertSnackBar.show(
        context: context,
        text: "O campo de CPF não pode estar vazio.",
      );
      return false;
    }
    if (!isValidCPF(_cpfController.text)) {
        AlertSnackBar.show(
          context: context,
          text: "O CPF informado é inválido.",
        );
        return false;
      }
    if (_birthDateController.text.isEmpty) {
      AlertSnackBar.show(
        context: context,
        text: "O campo de data de nascimento não pode estar vazio.",
      );
      return false;
    }
    if (_emailController.text.isEmpty) {
      AlertSnackBar.show(
        context: context,
        text: "O campo de e-mail não pode estar vazio.",
      );
      return false;
    }
    if (_role.isEmpty) {
      AlertSnackBar.show(
        context: context,
        text: "O campo de cargo não pode estar vazio.",
      );
      return false;
    }

    return true;
  }

  void _cancel() {
    Navigator.pop(context, true);
  }

  void _save() async {
    final employeeData = {
      'name': _nameController.text,
      'cpf': _cpfController.text.replaceAll(RegExp(r'\D'), ''),
      'birthDate': parseDateBackFront(_birthDateController.text),
      'email': _emailController.text,
      'login': _loginController.text,
      'password': _passwordController.text,
      'role': _role,
    };

    final response = await makeHttpRequest(context, 
      "/api/auth/Employee/$id",
      method: 'PUT',
      body: json.encode(employeeData),
    );

    if (response.statusCode == 200) {
      AlertSnackBar.show(
        context: context,
        text: "Funcionário editado com sucesso.",
        backgroundColor: AppColors.green,
      );

      Navigator.of(context).pop(true);
    } else {
      AlertSnackBar.show(
        context: context,
        text: "Falha ao editar funcionário.",
        backgroundColor: AppColors.red,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;
    fetchEmployeeData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> fetchEmployeeData() async {
    final response = await makeHttpRequest(context, "/api/auth/Employee/$id");

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _nameController.text = data['name'] ?? '';
        _cpfController.text = formatCpf(data['cpf']?.toString() ?? '');
        _birthDateController.text = formatDate(data['birthDate'] ?? '');
        _emailController.text = data['email'] ?? '';
        _loginController.text = data['login'] ?? '';
        _role = data['role']['description'] ?? '';
      });
    } else {
      throw Exception('Failed to load funcioário data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(children: [
        EmployeeForm(
          nameController: _nameController,
          cpfController: _cpfController,
          birthDateController: _birthDateController,
          onroleChanged: _updaterole,
          role: _role,
          key: UniqueKey(),
          emailController: _emailController,
          loginController: _loginController,
          passwordController: _passwordController,
          isEditing: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        label: "Cancelar",
                        onPressed: () {
                          _cancel();
                        },
                        color: const Color(0xFF838B91),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DefaultButton(
                        label: "Salvar",
                        onPressed: () {
                          if (verifyPage()) {
                            _save();
                          }
                        },
                        color: const Color(0xFF0C9C6F),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
  
}
