import 'package:ambiente_se/widgets/avaliacao_widgets/avaliation_options.dart';
import 'package:ambiente_se/widgets/avaliacao_widgets/finish_button.dart';
import 'package:ambiente_se/widgets/avaliacao_widgets/questions.dart';
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
  // PageController _pageController = PageController();
  PageController _pageController = PageController(initialPage: 4, keepPage: false);

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
                  Expanded(
                    child: ListView(
                      children: [
                        const PerguntaComOpcoes(pergunta: 'A empresa possui políticas de diversidade e inclusão?'),
                        const PerguntaComOpcoes(pergunta:'A empresa compromete-se com a saúde e segurança dos funcionários?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa oferece oportunidades de desenvolvimento e capacitação para os empregados?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa engaja-se com as comunidades locais onde opera?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa promove igualdade de gênero no local de trabalho?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui práticas de remuneração e benefícios justas?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui políticas contra assédio e discriminação?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa contribui para a educação e formação profissional na comunidade?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa realiza auditorias sociais em sua cadeia de suprimentos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa incentiva programas de voluntariado corporativo?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa apoia a saúde e o bem-estar dos funcionários além do local de trabalho?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui políticas contra trabalho infantil e trabalho forçado em sua cadeia de suprimentos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa lida com questões de direitos humanos em suas operações globais?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa envolve os funcionários em decisões importantes que os afetam?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui uma alta taxa de retenção de funcionários?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa promove a participação dos funcionários em iniciativas de responsabilidade social?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui práticas transparentes de comunicação com as partes interessadas?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa mede e relata seu impacto social?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa apoia iniciativas culturais e esportivas nas comunidades onde atua?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui políticas de equilíbrio entre vida pessoal e profissional para os funcionários?'),

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
                        const PerguntaComOpcoes(pergunta: 'A empresa possui uma estratégia clara de sustentabilidade ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa integra considerações ambientais em seu planejamento estratégico?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa realiza auditorias ambientais regulares?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui práticas de gestão de risco ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui uma política de governança ambiental documentada?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa gerencia a conformidade com as leis e regulamentos ambientais?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa divulga relatórios de sustentabilidade ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui práticas de transparência em relação ao seu impacto ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui um comitê de sustentabilidade ou um departamento dedicado ao meio ambiente?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa lida com a responsabilidade ambiental na cadeia de suprimentos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa promove a participação dos stakeholders nas decisões ambientais?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa tem políticas para prevenir e mitigar a poluição ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa gerencia e minimiza seu impacto ambiental ao longo do ciclo de vida dos produtos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui programas de treinamento ambiental para os funcionários?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui estratégias para reduzir suas emissões de carbono?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa investe em tecnologias limpas e sustentáveis?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa mede e gerencia seu consumo de recursos naturais?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa divulga seu desempenho ambiental em relatórios públicos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui práticas de responsabilidade ambiental em relação às comunidades locais?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa tem um histórico de iniciativas e projetos de conservação ambiental?'),

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
                        const PerguntaComOpcoes(pergunta: 'A empresa possui uma política ambiental clara e documentada?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui metas de redução de emissões de carbono?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa gerencia adequadamente seus resíduos sólidos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa utiliza fontes de energia renovável?'),
                        const PerguntaComOpcoes(pergunta: 'Existem programas de eficiência energética implementados na empresa?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa realiza auditorias ambientais regulares?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa gerencia seu consumo de água de forma sustentável?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui políticas de reciclagem em vigor?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa lida adequadamente com a poluição do ar e da água gerada por suas operações?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa tem iniciativas para conservar a biodiversidade?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa oferece programas de educação ambiental para os funcionários?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa divulga seu desempenho ambiental em relatórios de sustentabilidade?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa investe em tecnologias limpas e sustentáveis?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui certificações ambientais, como ISO 14001?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa trabalha para minimizar o impacto ambiental ao longo de sua cadeia de suprimentos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa avalia e mitiga o impacto ambiental de novos projetos?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa participa de iniciativas ou colaborações globais para a sustentabilidade ambiental?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui estratégias para lidar com as mudanças climáticas?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa incentiva práticas sustentáveis entre seus clientes e fornecedores?'),
                        const PerguntaComOpcoes(pergunta: 'A empresa possui um compromisso com a restauração de ecossistemas afetados por suas operações?'),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              PreviousPageButton(pageController: _pageController), // Botão de anterior
                              SizedBox(width: 50),
                              FinishButton(),
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
