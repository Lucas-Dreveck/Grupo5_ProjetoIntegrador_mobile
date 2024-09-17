import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_one.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_three.dart';
import 'package:ambiente_se/widgets/empresa_widgets/empresa_form_two.dart';
import 'package:flutter/material.dart';

class CadastroEmpresaPage extends StatefulWidget {
  const CadastroEmpresaPage({super.key});
  @override
  State<CadastroEmpresaPage> createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage> {
  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
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
  final TextEditingController _complementoController = TextEditingController();
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
    Navigator.of(context).pop();
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
    _complementoController.dispose();
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
              EmpresaFormOne(nomeFantasiaController: _nomeFantasiaController, cnpjController: _cnpjController, razaoSocialController: _razaoSocialController, ramoController: _ramoController, porte: _porte, onPorteChanged: _updatePorte),
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
              EmpresaFormThree(cepController: _cepController, cidadeController: _cidadeController, logradouroController: _logradouroController, bairroController: _bairroController, complementoController: _complementoController, uf: _uf, onUfChanged: _updateUF,),
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
