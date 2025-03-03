import 'package:ambiente_se/screens/company/edit_company_page.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/default/default_modal.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({super.key, required this.id});

  final int id;

  @override
  CompanyDetailsPageState createState() => CompanyDetailsPageState();
}

class CompanyDetailsPageState extends State<CompanyDetailsPage>
    with RouteAware {
  late int id;
  late TextEditingController cnpjController;
  late TextEditingController corporateNameController;
  late TextEditingController industryController;
  late TextEditingController tradeNameController;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    cnpjController = TextEditingController();
    corporateNameController = TextEditingController();
    industryController = TextEditingController();
    tradeNameController = TextEditingController();
    fetchCompanyData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    cnpjController.dispose();
    corporateNameController.dispose();
    industryController.dispose();
    tradeNameController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Atualiza os dados quando a tela de edição é removida da pilha de navegação
    fetchCompanyData();
  }

  Future<void> fetchCompanyData() async {
    final response = await makeHttpRequest(context, "/api/auth/Company/$id");

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      var cnpj = data['cnpj'];
      setState(() {
        cnpjController.text = formatCnpj(cnpj);
        tradeNameController.text = data['tradeName'] ?? '';
        corporateNameController.text = data['socialInscription'] ?? '';
        industryController.text = data['segment'] ?? '';
      });
    } else {
      throw Exception('Failed to load empresa data');
    }
  }

  Future<void> _delete() async {
    final response =
        await makeHttpRequest(context, "/api/auth/Company/$id", method: 'DELETE');

    if (response.statusCode == 200) {
      AlertSnackBar.show(
          context: context,
          text: "Empresa deletada com sucesso.",
          backgroundColor: AppColors.green);
      Navigator.of(context).pop();
    } else {
      AlertSnackBar.show(
          context: context,
          text: "Erro ao deletar empresa.",
          backgroundColor: AppColors.red);
      throw Exception('Failed to delete empresa');
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
              "Empresa",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DefaultTextField(
              label: 'CNPJ',
              hintText: "CNPJ",
              controller: cnpjController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Nome Fantasia',
              hintText: 'Nome Fantasia',
              controller: tradeNameController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Razão Social',
              hintText: 'Razão Social',
              controller: corporateNameController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            DefaultTextField(
              label: 'Ramo',
              hintText: 'Ramo',
              controller: industryController,
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
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCompanyPage(id: id),
                          ),
                        );
                        // Atualiza os dados quando a tela de edição é removida da pilha de navegação
                        fetchCompanyData();
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
