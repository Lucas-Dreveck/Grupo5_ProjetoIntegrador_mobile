import 'dart:convert';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/employee/employee_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({super.key, required this.id});

  final int id;

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
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

  void _cancel() {
    Navigator.of(context).pop();
  }

  void _finish() {
    Navigator.of(context).pop();
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
      body: Column(children: [
        EmployeeForm(
          nameController: _nameController,
          cpfController: _cpfController,
          birthDateController: _birthDateController,
          onroleChanged: _updaterole,
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
                            _finish();
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
