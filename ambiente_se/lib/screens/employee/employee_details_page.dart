import 'package:ambiente_se/screens/employee/edit_employee_page.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/default/default_modal.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<EmployeeDetailsPage> createState() => EmployeeDetailsPageState();
}

class EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late int id;

  late TextEditingController nameController;
  late TextEditingController cpfController;
  late TextEditingController birthDateController;
  late TextEditingController roleController;
  late TextEditingController emailController;
  late TextEditingController loginController;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    nameController = TextEditingController();
    cpfController = TextEditingController();
    birthDateController = TextEditingController();
    emailController = TextEditingController();
    loginController = TextEditingController();
    roleController = TextEditingController();
  }

  @override
  void dispose() {
    cpfController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    emailController.dispose();
    loginController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionário Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Empresa",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DefaultTextField(
              label: 'CPF',
              hintText: "CPF",
              controller: cpfController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Nome',
              hintText: 'Nome',
              controller: nameController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Data de Nascimento',
              hintText: 'Data de Nascimento', 
              controller: birthDateController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Cargo',
              hintText: 'Cargo',
              controller: roleController,
              enabled: false,
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                      label: "Voltar",
                      color: AppColors.grey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: DefaultButton(
                      label: "Editar",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmployeePage(id: id),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                    child: DefaultButton(
                        label: "Excluir",
                        color: AppColors.red, onPressed: () {  },
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
