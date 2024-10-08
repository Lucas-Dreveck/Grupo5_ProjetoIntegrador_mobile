import 'package:ambiente_se/widgets/default/default_dropdown.dart';
import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompanyFormOne extends StatefulWidget {
  final TextEditingController tradeNameController;
  final TextEditingController cnpjController;
  final TextEditingController corporateNameController;
  final TextEditingController industryController;
  final String companySize;
  final ValueChanged<String> oncompanySizeChanged;
  final bool isEditing;


  const CompanyFormOne({
    required Key key,
    required this.tradeNameController,
    required this.cnpjController,
    required this.corporateNameController,
    required this.industryController,
    required this.oncompanySizeChanged,
    this.companySize = "",
    this.isEditing = false,
  })  : super(key: key);
 
  @override
  CompanyFormOneState createState() => CompanyFormOneState();
}

class CompanyFormOneState extends State<CompanyFormOne> {
  var companySize;

  var cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );
  @override
  void initState() {
    super.initState();
    companySize = widget.companySize;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            widget.isEditing ? "Editar Empresa" : "Cadastro de Empresa",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Nome fantasia",
            hintText: "",
            controller: widget.tradeNameController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "CNPJ",
            hintText: "",
            type: TextInputType.number,
            mask: cnpjMask,
            controller: widget.cnpjController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Razão Social",
            hintText: "",
            controller: widget.corporateNameController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Ramo",
            hintText: "",
            controller: widget.industryController,
          ),
          const SizedBox(height: 15),
          DefaultDropdown(
            items: const ["Pequeno", "Médio", "Grande"],
            label: "Porte",
            initialValue: companySize != "" ? companySize : null,
            onChanged: (newCompanySize) {
              setState(() {
                companySize = newCompanySize.toString();
              });
              widget.oncompanySizeChanged(newCompanySize.toString());
            },
          ),
        ],
      ),
    );
  }
}