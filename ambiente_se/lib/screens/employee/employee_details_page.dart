import 'dart:convert';
import 'package:ambiente_se/screens/employee/edit_employee_page.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/default/default_modal.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<EmployeeDetailsPage> createState() => EmployeeDetailsPageState();
}

class EmployeeDetailsPageState extends State<EmployeeDetailsPage>
    with RouteAware {
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
    fetchEmployeeData();
  }

  @override
  void dispose() {
    cpfController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    loginController.dispose();
    roleController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void didPopNext() {
    final bool? result = ModalRoute.of(context)?.settings.arguments as bool?;
    if (result == true) {
      fetchEmployeeData();
    }
  }

  Future<void> fetchEmployeeData() async {
    final response = await makeHttpRequest("/api/auth/Employee/$id");

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      setState(() {
        nameController.text = data['name'] ?? '';
        cpfController.text = formatCpf(data['cpf'] ?? '');
        birthDateController.text = formatDate(data['birthDate'] ?? '');
        emailController.text = data['email'] ?? '';
        loginController.text = data['login'] ?? '';
        roleController.text = data['role']['description'] ?? '';
      });
    } else {
      throw Exception('Failed to load funcioário data');
    }
  }

  Future<void> _delete() async {
    final response =
        await makeHttpRequest("/api/auth/Employee/$id", method: 'DELETE');

    if (response.statusCode == 200) {
      AlertSnackBar.show(
          context: context,
          text: "Funcionário deletado com sucesso.",
          backgroundColor: AppColors.green);
      Navigator.pop(context, true);
    } else {
      AlertSnackBar.show(
          context: context,
          text: "Erro ao deletar funcionário.",
          backgroundColor: AppColors.red);
      throw Exception('Failed to delete funcionário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Funcionário",
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
                        Navigator.pop(context, true);
                      }),
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: DefaultButton(
                      label: "Editar",
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmployeePage(id: id),
                          ),
                        );

                        // Use the result to refresh only if necessary
                        if (result == true) {
                          fetchEmployeeData();
                        }
                      }),
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                    child: DefaultButton(
                        label: "Excluir",
                        color: AppColors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DefaultModal(
                                  text:
                                      "Deseja confirmar a exclusão da empresa",
                                  function: _delete,
                                  labelButtonOne: "Cancelar",
                                  colorButtonOne: AppColors.grey,
                                  labelButtonTwo: "Excluir",
                                  colorButtonTwo: AppColors.red,
                                );
                              });
                        })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
