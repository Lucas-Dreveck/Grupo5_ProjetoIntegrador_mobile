// ignore_for_file: use_build_context_synchronously
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/company/company_form_one.dart';
import 'package:ambiente_se/widgets/company/company_form_three.dart';
import 'package:ambiente_se/widgets/company/company_form_two.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:flutter/material.dart';



class CompanyRegistrationPage extends StatefulWidget {
  const CompanyRegistrationPage({super.key});
  @override
  State<CompanyRegistrationPage> createState() => CompanyRegistrationPageState();
}

class CompanyRegistrationPageState extends State<CompanyRegistrationPage> {
  final TextEditingController _tradeNameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _corporateNameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  var _companySize = "";
  void _updateCompanySize(String newCompanySize) {
    setState(() {
      _companySize = newCompanySize;
    });
  }
  final TextEditingController _requesterNameController = TextEditingController();
  final TextEditingController _requesterPhoneController = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyPhoneController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _publicSpaceController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
    final TextEditingController _numberController = TextEditingController();

  var _state = "";
  void _updateState(String newUF) {
    setState(() {
      _state = newUF;
    });
  }

  bool validatePageOne() {
    if (_tradeNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de nome fantasia não pode estar vazio.", );
      return false;
    }
    if (_cnpjController.text.isEmpty ) {
      AlertSnackBar.show(context: context, text: "O campo de CNPJ não pode estar vazio.", );
      return false;
    }
    if(_cnpjController.text.length < 18){
      AlertSnackBar.show(context: context, text: "O campo de CNPJ não está completo.", );
      return false;
    }
    if(!isValidCNPJ(_cnpjController.text)){
      AlertSnackBar.show(context: context, text: "O CNPJ informado é inválido.", );
      return false;
    }
    if (_corporateNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de razão social não pode estar vazio.", );
      return false;
    }
    if (_industryController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de ramo não pode estar vazio.", );
      return false;
    }
    if (_companySize == "") {
      AlertSnackBar.show(context: context, text: "O campo de companySize não pode estar vazio.", );
      return false;
    }

    return true;
  }

  bool validatePageTwo() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (_requesterNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de nome do solicitante não pode estar vazio.", );
      return false;
    }
    if (_requesterPhoneController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de telefone do solicitante não pode estar vazio.", );
      return false;
    }
    if(_requesterPhoneController.text.length < 18)
    {
      AlertSnackBar.show(context: context, text: "O campo de telefone do solicitante não está completo.", );
      return false;
    }
    if (_companyEmailController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de email da empresa não pode estar vazio.", );
      return false;
    }
    if (!emailRegex.hasMatch(_companyEmailController.text)) {
      AlertSnackBar.show(context: context, text: "O email informado é inválido.", );
      return false;
    }
    if (_companyPhoneController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de telefone da empresa não pode estar vazio.", );
      return false;
    }
    if( _companyPhoneController.text.length < 18){
      AlertSnackBar.show(context: context, text: "O campo de telefone da empresa não está completo.", );
      return false;
    }

    return true;
  }

  bool validatePageThree() {
    if (_postalCodeController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de CEP não pode estar vazio.", );
      return false;
    }
    if (_postalCodeController.text.length < 9){
      AlertSnackBar.show(context: context, text: "O campo de CEP não está completo.", );
      return false; 
    }
    if (_cityController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de cidade não pode estar vazio.", );
      return false;
    }
    if (_publicSpaceController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de logradouro não pode estar vazio.", );
      return false;
    }
    if (_neighborhoodController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de bairro não pode estar vazio.", );
      return false;
    }
    if (_state == "") {
      AlertSnackBar.show(context: context, text: "O campo de UF não pode estar vazio.", );
      return false;
    }
    if (_numberController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de número não pode estar vazio.", );
      return false;
    }
    return true;
  }


  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    // Avança para a próxima página
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _cancel() {
    Navigator.of(context).pop();
  }
 
  void _save() {
    final empresaData = {
      "nomeFantasia": _tradeNameController.text,
      "nomeSolicitante": _requesterNameController.text,
      "telefoneSolicitante": _requesterPhoneController.text.replaceAll(RegExp(r'\D'), ''),
      "razaoSocial": _corporateNameController.text,
      "cnpj": _cnpjController.text.replaceAll(RegExp(r'\D'), ''),
      "inscricaoSocial": null,
      "endereco": {
      "cep": _postalCodeController.text.replaceAll(RegExp(r'\D'), ''),
      "numero": _numberController.text.replaceAll(RegExp(r'\D'), ''), // Assuming you have a field for the number, replace 1 with the actual value
      "logradouro": _publicSpaceController.text,
      "complemento": null,
      "cidade": _cityController.text,
      "bairro": _neighborhoodController.text,
      "uf": _state,
      },
      "email": _companyEmailController.text,
      "telefoneEmpresas": _companyPhoneController.text.replaceAll(RegExp(r'\D'), ''),
      "ramo": _industryController.text,
      "companySizeEmpresas": _companySize,
      "ranking": null // Assuming ranking is not provided
        };

    _registerCompany(empresaData);
  
  }

  void _registerCompany(Map<String, dynamic> empresaData) async {
    // final url = Uri.parse('http://localhost:8080/auth/Empresa/Add');
    // var globalToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyb290IiwiY2FyZ28iOiJBZG1pbiIsImV4cCI6MTcyNjYyNDM3OH0.AXlyzVu09SvQGhhCNkhGNGD_QiY7UXa3FynlkK2ZplM";
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       "Authorization": globalToken,
    //     },
    //     body: json.encode(empresaData),
    //   );

    //   if (response.statusCode == 200) {
    //     if(context.mounted){
    //       AlertSnackBar.show(context: context, text: "Empresa cadastrada com sucesso.", backgroundColor: AppColors.green);
    //       Navigator.of(context).pop();
    //     }
    //   } else {
    //     if(context.mounted){
    //       AlertSnackBar.show(context: context, text: "Erro ao cadastrar empresa: ${response.statusCode}", backgroundColor: AppColors.red);
    //     }
    //   }
    // } catch (e) {
    //   if(context.mounted){
    //     AlertSnackBar.show(context: context, text: "Erro ao cadastrar empresa: $e", backgroundColor: AppColors.red);
    //   }
    // }
    AlertSnackBar.show(context: context, text: "Empresa cadastrada com sucesso.", backgroundColor: AppColors.green);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _tradeNameController.dispose();
    _cnpjController.dispose();
    _corporateNameController.dispose();
    _industryController.dispose();
    _requesterNameController.dispose();
    _requesterPhoneController.dispose();
    _companyEmailController.dispose();
    _companyPhoneController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _publicSpaceController.dispose();
    _neighborhoodController.dispose();
    _numberController.dispose();
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: const Text("Aoba"),
        backgroundColor: Colors.blue,
      ),
      body: 
      PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Column(
            children: [ 
              CompanyFormOne(tradeNameController: _tradeNameController, cnpjController: _cnpjController, corporateNameController: _corporateNameController, industryController: _industryController, companySize: _companySize, oncompanySizeChanged: _updateCompanySize,),
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
                              onPressed: () {_cancel();},
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DefaultButton(
                              label: "Próxima",
                              onPressed: () {
                                if (validatePageOne()) {
                                  _nextPage();
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ), 
            ] 
          ),
          

          // Pagina 2
          Column(
            children: [
              CompanyFormTwo(requesterNameController: _requesterNameController, requesterPhoneController: _requesterPhoneController, companyEmailController: _companyEmailController, companyPhoneController: _companyPhoneController),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DefaultButton(
                              label: "Cancelar",
                              onPressed: () {
                                _cancel();
                              },
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DefaultButton(
                              label: "Anterior",
                              onPressed: _prevPage,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DefaultButton(
                              label: "Próxima",
                              onPressed: () {
                                if(validatePageTwo()){
                                  _nextPage();
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Pagina 3
          Column(
            children: [
              CompanyFormThree(postalCodeController: _postalCodeController, cityController: _cityController, publicSpaceController: _publicSpaceController, neighborhoodController: _neighborhoodController, uf: _state, onUfChanged: _updateState, numberController: _numberController,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DefaultButton(
                              label: "Cancelar",
                              onPressed: () {
                                _cancel();
                              },
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DefaultButton(
                              label: "Anterior",
                              onPressed: _prevPage,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DefaultButton(
                              label: "Finalizar",
                              onPressed: () {
                                if(validatePageThree()){
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
              )
            ],
          ),
        ],
      ),
    );
  }
  
}


