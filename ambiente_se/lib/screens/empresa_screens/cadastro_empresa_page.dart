import 'dart:convert';

import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_one.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_three.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_two.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CadastroEmpresaPage extends StatefulWidget {
  const CadastroEmpresaPage({super.key});
  @override
  State<CadastroEmpresaPage> createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage> {
  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _inscricaoSocialController = TextEditingController();
  final TextEditingController _ramoController = TextEditingController();
  var _porte = "";
  void _updatePorte(String novoPorte) {
    setState(() {
      _porte = novoPorte;
    });
  }
  final TextEditingController _nomeSolicitanteController = TextEditingController();
  final TextEditingController _telefoneSolicitanteController = TextEditingController();
  final TextEditingController _emailEmpresaController = TextEditingController();
  final TextEditingController _telefoneEmpresaController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
    final TextEditingController _numeroController = TextEditingController();

  var _uf = "";
  void _updateUF(String novoUF) {
    setState(() {
      _uf = novoUF;
    });
  }


  bool verifarPaginaUm() {
    if (_nomeFantasiaController.text.isEmpty) {
      return false;
    }
    if (_cnpjController.text.isEmpty || _cnpjController.text.length < 18) {
      return false;
    }
    if (_razaoSocialController.text.isEmpty) {
      return false;
    }
    if (_ramoController.text.isEmpty) {
      return false;
    }
    if (_inscricaoSocialController.text.isEmpty || _inscricaoSocialController.text.length < 15) {
      return false;
    }
    if (_porte == "") {
      return false;
    }

    return true;
  }

  bool verifarPaginaDois() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (_nomeSolicitanteController.text.isEmpty) {
      return false;
    }
    if (_telefoneSolicitanteController.text.isEmpty || _telefoneSolicitanteController.text.length < 18) {
      return false;
    }
    if (_emailEmpresaController.text.isEmpty) {
      return false;
    }
    if (!emailRegex.hasMatch(_emailEmpresaController.text)) {
      return false;
    }
    if (_telefoneEmpresaController.text.isEmpty || _telefoneEmpresaController.text.length < 18) {

      return false;
    }

    return true;
  }

  bool verifarPaginaTres() {
    if (_cepController.text.isEmpty || _cepController.text.length < 9) {
      return false;
    }
    if (_cidadeController.text.isEmpty) {
      return false;
    }
    if (_logradouroController.text.isEmpty) {
      return false;
    }
    if (_bairroController.text.isEmpty) {
      return false;
    }
    if (_uf == "") {
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

  void _cancelar() {
    Navigator.of(context).pop();
  }
 
  void _finalizar() {
    final empresaData = {
      "nomeFantasia": _nomeFantasiaController.text,
      "nomeSolicitante": _nomeSolicitanteController.text,
      "telefoneSolicitante": _telefoneSolicitanteController.text.replaceAll(RegExp(r'\D'), ''),
      "razaoSocial": _razaoSocialController.text,
      "cnpj": _cnpjController.text.replaceAll(RegExp(r'\D'), ''),
      "inscricaoSocial": _inscricaoSocialController.text.replaceAll(RegExp(r'\D'), ''),
      "endereco": {
      "cep": _cepController.text.replaceAll(RegExp(r'\D'), ''),
      "numero": _numeroController.text.replaceAll(RegExp(r'\D'), ''), // Assuming you have a field for the number, replace 1 with the actual value
      "logradouro": _logradouroController.text,
      "complemento": null,
      "cidade": _cidadeController.text,
      "bairro": _bairroController.text,
      "uf": _uf,
      },
      "email": _emailEmpresaController.text,
      "telefoneEmpresas": _telefoneEmpresaController.text.replaceAll(RegExp(r'\D'), ''),
      "ramo": _ramoController.text,
      "porteEmpresas": _porte,
      "ranking": null // Assuming ranking is not provided
        };

    _cadastrarEmpresa(empresaData);
    
    print(empresaData);
  }

  void _cadastrarEmpresa(Map<String, dynamic> empresaData) async {
    final url = Uri.parse('http://localhost:8080/auth/Empresa/Add');
    var globalToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyb290IiwiY2FyZ28iOiJBZG1pbiIsImV4cCI6MTcyNjYyNDM3OH0.AXlyzVu09SvQGhhCNkhGNGD_QiY7UXa3FynlkK2ZplM";
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": globalToken,
        },
        body: json.encode(empresaData),
      );

      if (response.statusCode == 200) {
        print('Empresa cadastrada com sucesso');
        Navigator.of(context).pop();
      } else {
        print('Erro ao cadastrar empresa: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao cadastrar empresa: $e');
    }
  }

  @override
  void dispose() {
    _nomeFantasiaController.dispose();
    _cnpjController.dispose();
    _razaoSocialController.dispose();
    _ramoController.dispose();
    _nomeSolicitanteController.dispose();
    _telefoneSolicitanteController.dispose();
    _emailEmpresaController.dispose();
    _telefoneEmpresaController.dispose();
    _cepController.dispose();
    _cidadeController.dispose();
    _logradouroController.dispose();
    _bairroController.dispose();
    _numeroController.dispose();
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
              EmpresaFormOne(nomeFantasiaController: _nomeFantasiaController, cnpjController: _cnpjController, razaoSocialController: _razaoSocialController, ramoController: _ramoController, porte: _porte, onPorteChanged: _updatePorte, inscricaoSocialController: _inscricaoSocialController,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            
                            child: CadastroButton(
                              label: "Cancelar",
                              onPressed: () {_cancelar();},
                              color: const Color(0xFF838B91),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CadastroButton(
                              label: "Próxima",
                              onPressed: () {
                                if (verifarPaginaUm()) {
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
              EmpresaFormTwo(nomeSolicitanteController: _nomeSolicitanteController, telefoneSolicitanteController: _telefoneSolicitanteController, emailEmpresaController: _emailEmpresaController, telefoneEmpresaController: _telefoneEmpresaController),
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
                            child: CadastroButton(
                              label: "Cancelar",
                              onPressed: () {
                                _cancelar();
                              },
                              color: const Color(0xFF838B91),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CadastroButton(
                              label: "Anterior",
                              onPressed: _prevPage,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CadastroButton(
                              label: "Próxima",
                              onPressed: () {
                                if(verifarPaginaDois()){
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
              EmpresaFormThree(cepController: _cepController, cidadeController: _cidadeController, logradouroController: _logradouroController, bairroController: _bairroController, uf: _uf, onUfChanged: _updateUF, numeroController: _numeroController,),
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
                            child: CadastroButton(
                              label: "Cancelar",
                              onPressed: () {
                                _cancelar();
                              },
                              color: const Color(0xFF838B91),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CadastroButton(
                              label: "Anterior",
                              onPressed: _prevPage,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CadastroButton(
                              label: "Finalizar",
                              onPressed: () {
                                if(verifarPaginaTres()){
                                  _finalizar();
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
