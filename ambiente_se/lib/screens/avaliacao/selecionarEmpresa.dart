import 'package:ambiente_se/widgets/avaliacao_widgets/avaliation_options.dart';
import 'package:ambiente_se/widgets/avaliacao_widgets/finish_button.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/next_page_button.dart';
import 'package:ambiente_se/widgets/previous_page_button.dart';
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
  final TextEditingController selecionarEmpresaController = TextEditingController();
  SelecionarEmpresa? selectedEmpresa;
  PageController _pageController = PageController();
  // PageController _pageController = PageController(initialPage: 1, keepPage: false);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Desativa o deslizar manual
            children: [
// Primeira página
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Escolha a empresa para a avaliação',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownMenu<SelecionarEmpresa>(
                          initialSelection: SelecionarEmpresa.selecionar,
                          controller: selecionarEmpresaController,
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
                      CustomButton(
                        label: 'Avaliar', 
                        onPressed: (
                          selectedEmpresa != null &&
                          selectedEmpresa != SelecionarEmpresa.selecionar
                        ) ? () {
                          // Ir para a próxima página usando PageController
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } : null,
                      ),
                    ],
                  )
                ],
              ),
// Segunda página
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Social',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: OpcoesRadio(), // Widget de opções de rádio
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      NextPageButton(
                        pageController: _pageController,
                        label: 'Próxima página',
                        width: 255,
                      )
                    ],
                  ),
                ],
              ),
// Terceira página
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Governamental',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: OpcoesRadio(), // Widget de opções de rádio
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PreviousPageButton(pageController: _pageController), // Botão de anterior
                      SizedBox(width: 50),
                      NextPageButton(pageController: _pageController), // Botão de próxima página
                    ],
                  ),
                ],
              ),
// Quarta página
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Ambiental',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: OpcoesRadio(), // Widget de opções de rádio
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PreviousPageButton(pageController: _pageController), // Botão de anterior
                      SizedBox(width: 50),
                      FinishButton(pageController: _pageController),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
