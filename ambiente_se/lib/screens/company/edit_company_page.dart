// ignore: unused_import
import 'dart:convert';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:ambiente_se/widgets/default/default_button.dart';
import 'package:ambiente_se/widgets/company/company_form_one.dart';
import 'package:ambiente_se/widgets/company/company_form_three.dart';
import 'package:ambiente_se/widgets/company/company_form_two.dart';
import 'package:flutter/material.dart';

class EditCompanyPage extends StatefulWidget {
  const EditCompanyPage({super.key, required this.id});

  final int id;

  @override
  State<EditCompanyPage> createState() => EditCompanyPageState();
}

class EditCompanyPageState extends State<EditCompanyPage> {
  final TextEditingController _tradeNameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _corporateNameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  var _companySize = "";
  void _updatecompanySize(String newCompanySize) {
    setState(() {
      _companySize = newCompanySize;
    });
  }
  
  final TextEditingController _requesterNameController = TextEditingController();
  final TextEditingController _requesterPhoneController = TextEditingController();
  final TextEditingController _companyEmailController = TextEditingController();
  final TextEditingController _companyPhoneController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _publicSpaceController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  var _state = "";

  void _updateState(String newUF) {
    setState(() {
      print('Updating state from $_state to $newUF'); // Debugging statement

      _state = newUF;
      print('State updated to $_state'); 
    });
  }


  bool validatePageOne() {
    if (_tradeNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de nome fantasia não pode estar vazio.",);
      return false;
    }
    if (_cnpjController.text.isEmpty ) {
      AlertSnackBar.show(context: context, text: "O campo de CNPJ não pode estar vazio.",);
      return false;
    }
    if(_cnpjController.text.length < 18){
      AlertSnackBar.show(context: context, text: "O campo de CNPJ não está completo.",);
      return false;
    }
    if(!isValidCNPJ(_cnpjController.text)){
      AlertSnackBar.show(context: context, text: "O CNPJ informado é inválido.",);
      return false;
    }
    if (_corporateNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de razão social não pode estar vazio.",);
      return false;
    }
    if (_industryController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de ramo não pode estar vazio.",);
      return false;
    }
    if (_companySize == "") {
      AlertSnackBar.show(context: context, text: "O campo de companySize não pode estar vazio.",);
      return false;
    }

    return true;
  }

  bool validatePageTwo() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (_requesterNameController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de nome do solicitante não pode estar vazio.",);
      return false;
    }
    if (_requesterPhoneController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de telefone do solicitante não pode estar vazio.",);
      return false;
    }
    if(_requesterPhoneController.text.length < 18)
    {
      AlertSnackBar.show(context: context, text: "O campo de telefone do solicitante não está completo.",);
      return false;
    }
    if (_companyEmailController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de email da empresa não pode estar vazio.",);
      return false;
    }
    if (!emailRegex.hasMatch(_companyEmailController.text)) {
      AlertSnackBar.show(context: context, text: "O email informado é inválido.",);
      return false;
    }
    if (_companyPhoneController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de telefone da empresa não pode estar vazio.",);
      return false;
    }
    if( _companyPhoneController.text.length < 18){
      AlertSnackBar.show(context: context, text: "O campo de telefone da empresa não está completo.",);
      return false;
    }

    return true;
  }

  bool validatePageThree() {
    if (_postalCodeController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de CEP não pode estar vazio.",);
      return false;
    }
    if (_postalCodeController.text.length < 9){
      AlertSnackBar.show(context: context, text: "O campo de CEP não está completo.",);
      return false; 
    }
    if (_cityController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de cidade não pode estar vazio.",);
      return false;
    }
    if (_publicSpaceController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de logradouro não pode estar vazio.",);
      return false;
    }
    if (_neighborhoodController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de bairro não pode estar vazio.",);
      return false;
    }
    if (_state == "") {
      AlertSnackBar.show(context: context, text: "O campo de UF não pode estar vazio.",);
      return false;
    }
    if (_numberController.text.isEmpty) {
      AlertSnackBar.show(context: context, text: "O campo de número não pode estar vazio.",);
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
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _cancel() {
    Navigator.of(context).pop();
  }
 
  void _save() async {
    final companyData = {
      'imageUrl': _logoController.text,
      'tradeName': _tradeNameController.text,
      'applicantsName': _requesterNameController.text,
      'applicantsPhone': _requesterPhoneController.text.replaceAll(RegExp(r'\D'), ''),
      'companyName': _corporateNameController.text,
      'cnpj': _cnpjController.text.replaceAll(RegExp(r'\D'), ''),
      'socialInscription': _corporateNameController.text,
      'address': {
        'cep': _postalCodeController.text,
        'number': int.tryParse(_numberController.text) ?? 0,
        'patio': _publicSpaceController.text,
        'complement': '', // Assuming you have a complement to provide here
        'city': _cityController.text,
        'neighborhood': _neighborhoodController.text,
        'uf': _state,
      },
      'email': _companyEmailController.text,
      'companyPhone': _companyPhoneController.text.replaceAll(RegExp(r'\D'), ''),
      'segment': _industryController.text,
      'companySize': _companySize,
    };

    

    final response = await makeHttpRequest(context, 
      '/api/auth/Company/${widget.id}',
      method: 'PUT',
      body: json.encode(companyData),
    );

    if (response.statusCode == 200) {
      AlertSnackBar.show(context: context, text: "Empresa editada com sucesso.", backgroundColor: AppColors.green);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    } else {
      AlertSnackBar.show(context: context, text: "Ocorreu um erro ao editar a empresa.", backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
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

  void _fetchCompanyData() async {
    final response = await makeHttpRequest(context, '/api/auth/Company/${widget.id}');
    if (response.statusCode == 200 ) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _tradeNameController.text = data['tradeName']?.toString() ?? '';

        _cnpjController.text = formatCnpj(data['cnpj']?.toString() ?? '');

        _corporateNameController.text = data['socialInscription']?.toString() ?? '';

        _industryController.text = data['segment']?.toString() ?? '';

        _companySize = data['companySize']?.toString() ?? '';

        _requesterNameController.text = data['applicantsName']?.toString() ?? '';

        _requesterPhoneController.text = formatPhone(data['applicantsPhone']?.toString() ?? '');

        _companyEmailController.text = data['email']?.toString() ?? '';

        _companyPhoneController.text = formatPhone(data['companyPhone']?.toString() ?? '');

        _logoController.text = data['imageUrl']?.toString() ?? '';

        _postalCodeController.text = formatCep(data['addres']?['cep']?.toString() ?? '');

        _cityController.text = data['addres']?['city']?.toString() ?? '';

        _publicSpaceController.text = data['addres']?['patio']?.toString() ?? '';

        _neighborhoodController.text = data['addres']?['neighborhood']?.toString() ?? '';

        _numberController.text = data['addres']?['number']?.toString() ?? '';

        _state = data['addres']?['uf']?.toString() ?? '';
      });
    } else {
      AlertSnackBar.show(context: context, text: "Ocorreu um erro ao buscar dados da empresa.",);
    }
  }



  @override
  void initState() {
    super.initState();
    _fetchCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: 
      PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Column(
            children: [ 
              CompanyFormOne(tradeNameController: _tradeNameController, cnpjController: _cnpjController, corporateNameController: _corporateNameController, industryController: _industryController, companySize: _companySize, oncompanySizeChanged: _updatecompanySize, isEditing: true, key: UniqueKey(),), 
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
              CompanyFormTwo(requesterNameController: _requesterNameController, requesterPhoneController: _requesterPhoneController, companyEmailController: _companyEmailController, companyPhoneController: _companyPhoneController, logoController: _logoController, isEditing: true),
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
              CompanyFormThree(postalCodeController: _postalCodeController, cityController: _cityController, publicSpaceController: _publicSpaceController, neighborhoodController: _neighborhoodController, numberController: _numberController, uf: _state, onUfChanged: _updateState, isEditing: true, key: UniqueKey(),),
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
                              label: "Salvar",
                              onPressed: () {
                                if(validatePageThree()){
                                  _save();
                                }
                              },
                              color: AppColors.green,
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
