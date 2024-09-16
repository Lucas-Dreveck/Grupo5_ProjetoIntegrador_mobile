import 'package:flutter/material.dart';

class AvaliacaoPage extends StatefulWidget {
  const AvaliacaoPage({super.key});

  @override
  State<AvaliacaoPage> createState() => _AvaliacaoPageState();
}

enum SelecionarEmpresa {
  selecionar('Selecionar empresa'),
  empresa1('Empresa1'),
  empresa2('Empresa2'),
  empresa3('Empresa3');

  const SelecionarEmpresa(this.label);
  final String label;
}

class _AvaliacaoPageState extends State<AvaliacaoPage> {
  final TextEditingController selecionarEmpresaController =
      TextEditingController();
  SelecionarEmpresa? selectedEmpresa;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Escolha a empresa para a avaliação',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownMenu<SelecionarEmpresa>(
                      // textAlign: TextAlign.center,
                      initialSelection: SelecionarEmpresa.selecionar,
                      controller: selecionarEmpresaController,
                      // requestFocusOnTap is enabled/disabled by platforms when it is null.
                      // On mobile platforms, this is false by default. Setting this to true will
                      // trigger focus request on the text field and virtual keyboard will appear
                      // afterward. On desktop platforms however, this defaults to true.
                      requestFocusOnTap: true,
                      onSelected: (SelecionarEmpresa? empresa) {
                        setState(() {
                          selectedEmpresa = empresa;
                        });
                      },
                      dropdownMenuEntries: SelecionarEmpresa.values
                          .map<DropdownMenuEntry<SelecionarEmpresa>>(
                              (SelecionarEmpresa empresa) {
                        return DropdownMenuEntry<SelecionarEmpresa>(
                          value: empresa,
                          label: empresa.label,
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: (selectedEmpresa != null && selectedEmpresa != SelecionarEmpresa.selecionar) ? () {
                      // Ação quando `selectedEmpresa` não é nulo e `selecionar` está selecionado
                    } : null,
                    child: const Text('Avaliar', style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Color.fromRGBO(0, 119, 200, 1.0); // Cor quando o botão está desativado
                        }
                        return Color.fromRGBO(0, 119, 200, 1.0); // Cor quando o botão está ativo
                      }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
