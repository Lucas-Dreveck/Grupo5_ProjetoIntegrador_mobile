import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/default/default_dropdown.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyFormThree extends StatefulWidget {
  final TextEditingController postalCodeController;
  final TextEditingController cityController;
  final TextEditingController publicSpaceController;
  final TextEditingController neighborhoodController;
  final TextEditingController numberController;
  final ValueChanged<String> onUfChanged;
  final String uf;
  final bool isEditing;

  const CompanyFormThree({
    required Key key,
    required this.postalCodeController,
    required this.cityController,
    required this.publicSpaceController,
    required this.neighborhoodController,
    required this.numberController,
    required this.uf,
    required this.onUfChanged,
    this.isEditing = false,
  }) : super(key: key);

  @override
  CompanyFormThreeState createState() => CompanyFormThreeState();
}

class CompanyFormThreeState extends State<CompanyFormThree> {
  late TextEditingController postalCodeController;
  late TextEditingController cityController;
  late TextEditingController publicSpaceController;
  late TextEditingController neighborhoodController;
  late TextEditingController numberController;
  late String uf;

  var postalCodeMask = MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static const List<String> ufsBrasil = [
    'AC', // 
    'AL', // 
    'AP', // 
    'AM', // 
    'BA', // 
    'CE', // 
    'DF', //  
    'ES', //  
    'GO', // 
    'MA', // 
    'MT', // 
    'MS', // 
    'MG', // 
    'PA', // 
    'PB', // 
    'PR', // 
    'PE', // 
    'PI', // 
    'RJ', // 
    'RN', // 
    'RS', // 
    'RO', // 
    'RR', // 
    'SC', // 
    'SP', // 
    'SE', // 
    'TO', // 
  ];
  
  void _fetchAddressFromCEP(String cep) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['erro'] == null) {
        if(mounted){
          setState(() {
            publicSpaceController.text = data['logradouro'] ?? '';
            neighborhoodController.text = data['bairro'] ?? '';
            cityController.text = data['localidade'] ?? '';
            numberController.text = ''; 
            uf = data['uf'] ?? ''; 
            widget.onUfChanged(uf);


          });
        }
      } else {
        AlertSnackBar.show(context: context, text: "CEP não encontrado.");
      }
    } else {
      AlertSnackBar.show(context: context, text: "Erro ao buscar CEP.");
    }
  }

  @override
  void initState() {
    super.initState();
    postalCodeController = widget.postalCodeController;
    publicSpaceController = widget.publicSpaceController;
    neighborhoodController = widget.neighborhoodController;
    cityController = widget.cityController;
    numberController = widget.numberController;

    postalCodeController.addListener(() {
      if (postalCodeController.text.length == 9) {
        _fetchAddressFromCEP(postalCodeController.text);
      }
    });
    uf = widget.uf;
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Cadastro de Empresa",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            type: TextInputType.number,
            mask: postalCodeMask,
            label: "CEP",
            hintText: "",
            controller: widget.postalCodeController,
          ),
          const SizedBox(height: 15),
          DefaultDropdown(
            items: ufsBrasil,
            label: "UF",
            initialValue: uf != "" ? uf : null,
            onChanged: (newUF) {
              setState(() {
                uf = newUF!;
              });
              widget.onUfChanged(newUF.toString());
            },
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Cidade",
            hintText: "",
            controller: widget.cityController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Logradouro",
            hintText: "",
            controller: widget.publicSpaceController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Bairro",
            hintText: "",
            controller: widget.neighborhoodController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Numero",
            type: TextInputType.number,
            hintText: "",
            controller: widget.numberController,
          ),
        ]
      )
    );
  }
}
