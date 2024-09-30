import 'package:ambiente_se/screens/evaluation/results_page.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/finish_button.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/questions.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/next_page_button.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/previous_page_button.dart';
import 'package:flutter/material.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({super.key});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

enum SelectCompany {
  selecionar('Selecionar empresa'),
  company1('Empresa1'),
  company2('Empresa2'),
  company3('Empresa3');

  const SelectCompany(this.label);
  final String label;
}

class _EvaluationPageState extends State<EvaluationPage> {
  final TextEditingController SelectCompanyController = TextEditingController();
  SelectCompany? selectedCompany;
  PageController _pageController = PageController();
  // PageController _pageController = PageController(initialPage: 4, keepPage: false);
  int currentPage = 0;

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
                        DropdownMenu<SelectCompany>(
                          initialSelection: SelectCompany.selecionar,
                          controller: SelectCompanyController,
                          requestFocusOnTap: true,
                          onSelected: (SelectCompany? company) {
                            setState(() {
                              selectedCompany = company;
                            });
                          },
                          dropdownMenuEntries: SelectCompany.values
                              .map<DropdownMenuEntry<SelectCompany>>(
                                  (SelectCompany company) {
                            return DropdownMenuEntry<SelectCompany>(
                              value: company,
                              label: company.label,
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
                          selectedCompany != null &&
                          selectedCompany != SelectCompany.selecionar
                        ) ? () {
                          if (currentPage < 3) {
                            // Verifica se não está na última página
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              currentPage++;
                            });
                          } else {
                            // Se estiver na última página, navega para a RestultsPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultsPage(
                                  companyName: selectedCompany?.label ??
                                      'Nenhuma empresa selecionada',
                                ),
                              ),
                            );
                          }
                        }
                        : null, // Desativa o botão se nenhuma empresa foi selecionada
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
                  Expanded(
                    child: ListView(
                      children: [
                        const Questions(
                            question:
                                'A empresa possui políticas de diversidade e inclusão?'),
                        const Questions(
                            question:
                                'A empresa compromete-se com a saúde e segurança dos funcionários?'),
                        const Questions(
                            question:
                                'A empresa oferece oportunidades de desenvolvimento e capacitação para os empregados?'),
                        const Questions(
                            question:
                                'A empresa engaja-se com as comunidades locais onde opera?'),
                        const Questions(
                            question:
                                'A empresa promove igualdade de gênero no local de trabalho?'),
                        const Questions(
                            question:
                                'A empresa possui práticas de remuneração e benefícios justas?'),
                        const Questions(
                            question:
                                'A empresa possui políticas contra assédio e discriminação?'),
                        const Questions(
                            question:
                                'A empresa contribui para a educação e formação profissional na comunidade?'),
                        const Questions(
                            question:
                                'A empresa realiza auditorias sociais em sua cadeia de suprimentos?'),
                        const Questions(
                            question:
                                'A empresa incentiva programas de voluntariado corporativo?'),
                        const Questions(
                            question:
                                'A empresa apoia a saúde e o bem-estar dos funcionários além do local de trabalho?'),
                        const Questions(
                            question:
                                'A empresa possui políticas contra trabalho infantil e trabalho forçado em sua cadeia de suprimentos?'),
                        const Questions(
                            question:
                                'A empresa lida com questões de direitos humanos em suas operações globais?'),
                        const Questions(
                            question:
                                'A empresa envolve os funcionários em decisões importantes que os afetam?'),
                        const Questions(
                            question:
                                'A empresa possui uma alta taxa de retenção de funcionários?'),
                        const Questions(
                            question:
                                'A empresa promove a participação dos funcionários em iniciativas de responsabilidade social?'),
                        const Questions(
                            question:
                                'A empresa possui práticas transparentes de comunicação com as partes interessadas?'),
                        const Questions(
                            question:
                                'A empresa mede e relata seu impacto social?'),
                        const Questions(
                            question:
                                'A empresa apoia iniciativas culturais e esportivas nas comunidades onde atua?'),
                        const Questions(
                            question:
                                'A empresa possui políticas de equilíbrio entre vida pessoal e profissional para os funcionários?'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              NextPageButton(
                                pageController: _pageController,
                                label: 'Próxima página',
                                width: 255,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                  Expanded(
                    child: ListView(
                      children: [
                        const Questions(
                            question:
                                'A empresa possui uma estratégia clara de sustentabilidade ambiental?'),
                        const Questions(
                            question:
                                'A empresa integra considerações ambientais em seu planejamento estratégico?'),
                        const Questions(
                            question:
                                'A empresa realiza auditorias ambientais regulares?'),
                        const Questions(
                            question:
                                'A empresa possui práticas de gestão de risco ambiental?'),
                        const Questions(
                            question:
                                'A empresa possui uma política de governança ambiental documentada?'),
                        const Questions(
                            question:
                                'A empresa gerencia a conformidade com as leis e regulamentos ambientais?'),
                        const Questions(
                            question:
                                'A empresa divulga relatórios de sustentabilidade ambiental?'),
                        const Questions(
                            question:
                                'A empresa possui práticas de transparência em relação ao seu impacto ambiental?'),
                        const Questions(
                            question:
                                'A empresa possui um comitê de sustentabilidade ou um departamento dedicado ao meio ambiente?'),
                        const Questions(
                            question:
                                'A empresa lida com a responsabilidade ambiental na cadeia de suprimentos?'),
                        const Questions(
                            question:
                                'A empresa promove a participação dos stakeholders nas decisões ambientais?'),
                        const Questions(
                            question:
                                'A empresa tem políticas para prevenir e mitigar a poluição ambiental?'),
                        const Questions(
                            question:
                                'A empresa gerencia e minimiza seu impacto ambiental ao longo do ciclo de vida dos produtos?'),
                        const Questions(
                            question:
                                'A empresa possui programas de treinamento ambiental para os funcionários?'),
                        const Questions(
                            question:
                                'A empresa possui estratégias para reduzir suas emissões de carbono?'),
                        const Questions(
                            question:
                                'A empresa investe em tecnologias limpas e sustentáveis?'),
                        const Questions(
                            question:
                                'A empresa mede e gerencia seu consumo de recursos naturais?'),
                        const Questions(
                            question:
                                'A empresa divulga seu desempenho ambiental em relatórios públicos?'),
                        const Questions(
                            question:
                                'A empresa possui práticas de responsabilidade ambiental em relação às comunidades locais?'),
                        const Questions(
                            question:
                                'A empresa tem um histórico de iniciativas e projetos de conservação ambiental?'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              PreviousPageButton(pageController: _pageController), // Botão de anterior
                              SizedBox(width: 50),
                              NextPageButton(pageController: _pageController), // Botão de próxima página
                            ],
                          ),
                        ),
                      ],
                    ),
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
                  Expanded(
                    child: ListView(
                      children: [
                        const Questions(
                            question:
                                'A empresa possui uma política ambiental clara e documentada?'),
                        const Questions(
                            question:
                                'A empresa possui metas de redução de emissões de carbono?'),
                        const Questions(
                            question:
                                'A empresa gerencia adequadamente seus resíduos sólidos?'),
                        const Questions(
                            question:
                                'A empresa utiliza fontes de energia renovável?'),
                        const Questions(
                            question:
                                'Existem programas de eficiência energética implementados na empresa?'),
                        const Questions(
                            question:
                                'A empresa realiza auditorias ambientais regulares?'),
                        const Questions(
                            question:
                                'A empresa gerencia seu consumo de água de forma sustentável?'),
                        const Questions(
                            question:
                                'A empresa possui políticas de reciclagem em vigor?'),
                        const Questions(
                            question:
                                'A empresa lida adequadamente com a poluição do ar e da água gerada por suas operações?'),
                        const Questions(
                            question:
                                'A empresa tem iniciativas para conservar a biodiversidade?'),
                        const Questions(
                            question:
                                'A empresa oferece programas de educação ambiental para os funcionários?'),
                        const Questions(
                            question:
                                'A empresa divulga seu desempenho ambiental em relatórios de sustentabilidade?'),
                        const Questions(
                            question:
                                'A empresa investe em tecnologias limpas e sustentáveis?'),
                        const Questions(
                            question:
                                'A empresa possui certificações ambientais, como ISO 14001?'),
                        const Questions(
                            question:
                                'A empresa trabalha para minimizar o impacto ambiental ao longo de sua cadeia de suprimentos?'),
                        const Questions(
                            question:
                                'A empresa avalia e mitiga o impacto ambiental de novos projetos?'),
                        const Questions(
                            question:
                                'A empresa participa de iniciativas ou colaborações globais para a sustentabilidade ambiental?'),
                        const Questions(
                            question:
                                'A empresa possui estratégias para lidar com as mudanças climáticas?'),
                        const Questions(
                            question:
                                'A empresa incentiva práticas sustentáveis entre seus clientes e fornecedores?'),
                        const Questions(
                            question:
                                'A empresa possui um compromisso com a restauração de ecossistemas afetados por suas operações?'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              PreviousPageButton(pageController: _pageController), // Botão de anterior
                              SizedBox(width: 50),
                              FinishButton(
                                companyName: selectedCompany?.label ??
                                'Nenhuma empresa selecionada',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
