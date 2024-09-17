import 'package:ambiente_se/screens/empresa_screens/editar_empresa_page.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_button.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_modal.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmpresaPage extends StatefulWidget {
  const EmpresaPage({super.key, required this.id});

  final int id;

  @override
  _EmpresaPageState createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  late TextEditingController cnpjController;
  late TextEditingController razaoSocialController;
  late TextEditingController ramoController;

  String cnpj = '';
  String razaoSocial = '';
  String ramo = '';

  @override
  void initState() {
    super.initState();
    cnpjController = TextEditingController();
    razaoSocialController = TextEditingController();
    ramoController = TextEditingController();
    fetchEmpresaData();
  }

  @override
  void dispose() {
    cnpjController.dispose();
    razaoSocialController.dispose();
    ramoController.dispose();
    super.dispose();
  }

  Future<void> fetchEmpresaData() async {
    const uri = "https://ca59c6680290df512b38.free.beeceptor.com";
    //const uri1 = 'https://api.exemplo.com/empresa/${widget.id}';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200 || 1==1) {
      //final data = json.decode(response.body);
      final data = {};
      data['cnpj'] = '12345678000195';
      data['razaoSocial'] = 'Empresa Exemplo Ltda';
      data['ramo'] = 'Tecnologia';
      setState(() {
        cnpjController.text = data['cnpj'];
        razaoSocialController.text = data['razaoSocial'];
        ramoController.text = data['ramo'];
      });


    } else {
      throw Exception('Failed to load empresa data');
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresa Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Empresas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            CadastroTextField(
              label: 'CNPJ',
              hintText: cnpj,
              controller: cnpjController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            CadastroTextField(
              label: 'Razão Social',
              hintText: 'Razão Social',
              controller: razaoSocialController,
              enabled: false,
            ),
            const SizedBox(height: 16.0),
            CadastroTextField(
              label: 'Ramo',
              hintText: 'Ramo',
              controller: ramoController,
              enabled: false,
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(child: CadastroButton(label: "Voltar", color: const Color(0xFF838B91), onPressed: (){Navigator.of(context).pop();}),),
                const SizedBox(width: 11,),
                Expanded(child: CadastroButton(label: "Editar", onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => EditarEmpresaPage(id: 1),
                    ),
                  );}),),
                const SizedBox(width: 11,),
                Expanded(child: CadastroButton(
                  label: "Excluir", 
                  color: const Color(0xffDF2935), 
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CadastroModal(text: "Deseja confirmar a exclusão da empresa", function: (){Navigator.of(context).pop();}, labelButtonOne: "Cancelar", colorButtonOne: const Color(0xff838B91), labelButtonTwo: "Excluir", colorButtonTwo: const Color(0xffDF2935));
                      }
                    );
                    }
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}