import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';

class CadastroEmpresaPage extends StatefulWidget {
  const CadastroEmpresaPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroEmpresaPage> createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage>{

  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _ramoController = TextEditingController();
  final TextEditingController _porteController = TextEditingController();

  final TextEditingController _nomeSolicitanteController = TextEditingController();
  final TextEditingController _telefoneSolicitanteController = TextEditingController();
  final TextEditingController _emailEmpresaController = TextEditingController();
  final TextEditingController _telefoneEmpresaController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();



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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: PageView(
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
                  hintText: "",
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
                CadastroTextField(
                  label: "Porte",
                  hintText: "",
                  controller: _porteController,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(child: CadastroButton(
                        label: "Próxima",
                        onPressed: _nextPage,
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
                  hintText: "",
                  controller: _telefoneSolicitanteController,
                ),
                const SizedBox(height: 15),
                CadastroTextField(
                  label: "Email da empresa",
                  hintText: "",
                  controller: _emailEmpresaController,
                ),
                const SizedBox(height: 15),
                CadastroTextField(
                  label: "Telefone da empresa",
                  hintText: "",
                  controller: _telefoneEmpresaController,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CadastroButton(
                        label: "Anterior",
                        onPressed: _prevPage,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: CadastroButton(
                        label: "Próxima",
                        onPressed: _nextPage,
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
                  label: "CEP",
                  hintText: "",
                  controller: _cepController,
                ),
                const SizedBox(height: 15),
                CadastroTextField(
                  label: "UF",
                  hintText: "",
                  controller: _ufController,
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
                        label: "Anterior",
                        onPressed: _prevPage,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                    child: CadastroButton(
                      label: "Finalizar",
                      onPressed: _nextPage,
                      color: Color(0xFF0C9C6F),
                    ),
                    )

                  ],
                )
              ],
            ),
          ), 
        ],
      ),
    );
  }
}