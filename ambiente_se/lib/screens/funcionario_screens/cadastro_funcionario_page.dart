import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/funcionario_widgets/funcionario_form.dart';
import 'package:flutter/material.dart';

class CadastroFuncionarioPage extends StatefulWidget {
  const CadastroFuncionarioPage({super.key});

  @override
  @override
  State<CadastroFuncionarioPage> createState() =>
      _CadastroFuncionarioPageState();
}

class _CadastroFuncionarioPageState extends State<CadastroFuncionarioPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  var _cargo = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _updateCargo(String novoCargo) {
    setState(() {
      _cargo = novoCargo;
    });
  }

  void _cancelar() {
    Navigator.of(context).pop();
  }

  void _finalizar() {
    Navigator.of(context).pop();
  }

  bool verificarPagina(){
    if(_nomeController.text.isNotEmpty && _cpfController.text.isNotEmpty && _dataNascimentoController.text.isNotEmpty && _emailController.text.isNotEmpty && _loginController.text.isNotEmpty && _senhaController.text.isNotEmpty){
      return true;
    }
    return false;
  }


  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Cadastro funcionário"),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        FuncionarioForm(
            nomeController: _nomeController,
            cpfController: _cpfController,
            dataNascimentoController: _dataNascimentoController,
            onCargoChanged: _updateCargo,
            emailController: _emailController,
            loginController: _loginController,
            senhaController: _senhaController),
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
                              label: "Finalizar",
                              onPressed: () {
                                if(verificarPagina()){
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
        ),
      ]),
    );
  }
}
