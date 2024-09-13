import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_dropdown.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroEmpresaPage extends StatefulWidget {
  const CadastroEmpresaPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroEmpresaPage> createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage> {
  var mascaraTelefone = new MaskTextInputFormatter(
    mask: '+## (##)#####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  var mascaraCep = new MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  var mascaraCnpj = new MaskTextInputFormatter(
    mask: '##.###.###/####-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );


  static const List<String> ufsBrasil = [
    'AC', // Acre
    'AL', // Alagoas
    'AP', // Amapá
    'AM', // Amazonas
    'BA', // Bahia
    'CE', // Ceará
    'DF', // Distrito Federal
    'ES', // Espírito Santo
    'GO', // Goiás
    'MA', // Maranhão
    'MT', // Mato Grosso
    'MS', // Mato Grosso do Sul
    'MG', // Minas Gerais
    'PA', // Pará
    'PB', // Paraíba
    'PR', // Paraná
    'PE', // Pernambuco
    'PI', // Piauí
    'RJ', // Rio de Janeiro
    'RN', // Rio Grande do Norte
    'RS', // Rio Grande do Sul
    'RO', // Rondônia
    'RR', // Roraima
    'SC', // Santa Catarina
    'SP', // São Paulo
    'SE', // Sergipe
    'TO', // Tocantins
  ];

  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _ramoController = TextEditingController();
  var _porte;


  final TextEditingController _nomeSolicitanteController = TextEditingController();
  final TextEditingController _telefoneSolicitanteController = TextEditingController();
  final TextEditingController _emailEmpresaController = TextEditingController();
  final TextEditingController _telefoneEmpresaController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  var _uf;


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
    if (_porte == null) {
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
      print('Por favor, insira um e-mail válido') ;
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
    if (_uf == null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color(0XFFFCFCFC),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            //Pagina 1
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Cadastro de Empresa",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Nome fantasia",
                    hintText: "",
                    controller: _nomeFantasiaController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "CNPJ",
                    type: TextInputType.number,
                    hintText: "",
                    mask: mascaraCnpj,
                    controller: _cnpjController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Razão social",
                    hintText: "",
                    controller: _razaoSocialController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Ramo",
                    hintText: "",
                    controller: _ramoController,
                  ),
                  const SizedBox(height: 15),
                  CadastroDropdown(
                    items: ["Pequeno", "Médio", "Grande"],
                    label: "Porte",
                    onChanged: (novoPorte) {
                      setState(() {
                        _porte = novoPorte;
                      });
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CadastroButton(
                          label: "Cancelar",
                          onPressed: () {
                            print("cancelando");
                          },
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

            // Pagina 2
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Cadastro de Empresa",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Nome do solicitante",
                    hintText: "",
                    controller: _nomeSolicitanteController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Telefone do solicitante",
                    type: TextInputType.number,
                    hintText: "",
                    controller: _telefoneSolicitanteController,
                    mask: mascaraTelefone,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Email da empresa",
                    type: TextInputType.emailAddress,
                    hintText: "",
                    controller: _emailEmpresaController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Telefone da empresa",
                    type: TextInputType.number,
                    hintText: "",
                    controller: _telefoneEmpresaController,
                    mask: mascaraTelefone,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CadastroButton(
                          label: "Cancelar",
                          onPressed: () {
                            print("cancelando");
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

            // Pagina 3
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Cadastro de Empresa",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    type: TextInputType.number,
                    mask: mascaraCep,
                    label: "CEP",
                    hintText: "",
                    controller: _cepController,
                  ),
                  const SizedBox(height: 15),
                  CadastroDropdown(
                    items: ufsBrasil,
                    label: "UF",
                    onChanged: (novoUF) {
                      setState(() {
                        _uf = novoUF;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Cidade",
                    hintText: "",
                    controller: _cidadeController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Logradouro",
                    hintText: "",
                    controller: _logradouroController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Bairro",
                    hintText: "",
                    controller: _bairroController,
                  ),
                  const SizedBox(height: 15),
                  CadastroTextField(
                    label: "Complemento",
                    hintText: "",
                    controller: _complementoController,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CadastroButton(
                          label: "Cancelar",
                          onPressed: () {
                            print("cancelando");
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
                              print("Deu certo!");
                              print(_cepController.text);
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
          ],
        ),
      ),
    );
  }
}
