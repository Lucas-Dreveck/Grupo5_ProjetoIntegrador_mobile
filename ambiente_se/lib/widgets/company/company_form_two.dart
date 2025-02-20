import 'package:ambiente_se/widgets/default/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompanyFormTwo extends StatefulWidget {
  final TextEditingController requesterNameController;
  final TextEditingController requesterPhoneController;
  final TextEditingController companyEmailController;
  final TextEditingController companyPhoneController;
  final TextEditingController logoController;
  final bool isEditing;

  const CompanyFormTwo({super.key, 
    required this.requesterNameController,
    required this.requesterPhoneController,
    required this.companyEmailController,
    required this.companyPhoneController,
    required this.logoController,
    this.isEditing = false,
  });

  @override
  CompanyFormTwoState createState() => CompanyFormTwoState();
}

class CompanyFormTwoState extends State<CompanyFormTwo> {

  var phoneMask = MaskTextInputFormatter(
    mask: '+## (##)#####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );


  
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
            label: "Nome do solicitante",
            hintText: "",
            controller: widget.requesterNameController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Telefone do solicitante",
            type: TextInputType.number,
            hintText: "",
            controller: widget.requesterPhoneController,
            mask: phoneMask,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Email da empresa",
            type: TextInputType.emailAddress,
            hintText: "",
            controller: widget.companyEmailController,
          ),
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Telefone da empresa",
            type: TextInputType.number,
            hintText: "",
            controller: widget.companyPhoneController,
            mask: phoneMask,
          ), 
          const SizedBox(height: 15),
          DefaultTextField(
            label: "Url Logo (opcional)",
            hintText: "",
            controller: widget.logoController,
          ),
        ]
      ),
    );
  }
}