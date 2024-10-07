import 'dart:convert';

import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/employee/employee_form.dart';
import 'package:flutter/material.dart';

class EmployeeRegistrationPage extends StatefulWidget {
  const EmployeeRegistrationPage({super.key});

  @override
  State<EmployeeRegistrationPage> createState() =>
      _EmployeeRegistrationPageState();
}

class _EmployeeRegistrationPageState extends State<EmployeeRegistrationPage> {
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

  void _cancel() {
    Navigator.of(context).pop();
  }

  void _finish() {
    Navigator.of(context).pop();
  }

  bool verifyPage() {
    if (_nameController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _birthDateController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _loginController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void _save() {
    final employeeData = {
      "name": _nameController.text,
      "cpf": _cpfController.text.replaceAll(RegExp(r'\D'), ''),
      "email": _emailController.text,
      "birthDate": formatDate(_birthDateController.text),
      "user": {
        "login": _loginController.text,
        "password": _passwordController.text,
        "isAdmin": _role == "gestor" ? true : false
      },
      "role": _role,
    };

    _registerEmployee(employeeData);
  }

  void _registerEmployee(Map<String, dynamic> employeeData) async {
    const url = '/api/auth/Employee';
    try {
      final response = await makeHttpRequest(url,
          method: 'POST', body: jsonEncode(employeeData));
      if (response.statusCode == 200) {
        AlertSnackBar.show(
            context: context,
            text: "Funcionário cadastrado com sucesso.",
            backgroundColor: AppColors.green);
        Navigator.of(context).pop();
      } else {
        AlertSnackBar.show(
            context: context,
            text: "Erro ao cadastrar funcionário.",
            backgroundColor: AppColors.red);
      }
    } catch (e) {
      AlertSnackBar.show(
          context: context,
          text: "Erro ao cadastrar funcionário",
          backgroundColor: AppColors.red);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Cadastro funcionário"),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        EmployeeForm(
            nameController: _nameController,
            cpfController: _cpfController,
            birthDateController: _birthDateController,
            onroleChanged: _updaterole,
            emailController: _emailController,
            loginController: _loginController,
            passwordController: _passwordController),
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
