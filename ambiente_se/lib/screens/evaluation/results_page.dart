import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultsPage extends StatelessWidget {
  final String companyName;

  const ResultsPage({Key? key, required this.companyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da Avaliação'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Resultados \n $companyName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // Exibindo os círculos de porcentagem de conformidade por categoria
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPercentageAccordance(
                  'Social', 
                  100, 
                  const Color.fromRGBO(240, 135, 11, 1.0)
                ),
                _buildPercentageAccordance(
                  'Governamental', 
                  100,
                  const Color.fromRGBO(0, 119, 200, 1.0)
                ),
                _buildPercentageAccordance(
                  'Ambiental', 
                  100, 
                  const Color.fromRGBO(106, 192, 74, 1.0)
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildResultsCategory(
              _socialQuestions(),
              const Color.fromRGBO(240, 135, 11, 1.0)
            ),
            _buildResultsCategory(
              _governmentQuestions(),
              const Color.fromRGBO(0, 113, 191, 1.0)
            ),
            _buildResultsCategory(
              _environmentalQuestions(),
              const Color.fromRGBO(106, 192, 74, 1.0)
            ),
          ],
        ),
      ),
    );
  }

  // Função para mostrar a porcentagem de conformidade por categoria com cor específica
  Widget _buildPercentageAccordance(String category, double percentage, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50,
          backgroundColor: Color.fromRGBO(254, 247, 255, 1.0),
          lineWidth: 10.0,
          percent: percentage / 100,
          progressColor: color,
          animation: true,
          animationDuration: 1200,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 21, color: Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          category,
          style: TextStyle(fontSize: 21, color: Colors.black),
        ),
      ],
    );
  }

  // Função para construir as seções de cada categoria com cor específica
  Widget _buildResultsCategory(List<String> questions, Color color) {
    List<TableRow> rows = [];

    // Cabeçalho "Perguntas" e "Respostas"
    rows.add(
      TableRow(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: const Text(
                'Perguntas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: const Text(
                'Respostas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center
              ),
            ),
          ),
        ],
      ),
    );

    bool alternate = true; // Variável para alternar cores das linhas

    for (String question in questions) {
      rows.add(
        TableRow(
          children: [
            Container(
              color:
                alternate ? color.withOpacity(1.0) : color.withOpacity(0.5),
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center
                ),
              ),
              height: 90,
            ),
            Container(
              color:
                alternate ? color.withOpacity(1.0) : color.withOpacity(0.5),
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  // resposta,
                  'De Acordo',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              height: 90,
            ),
          ],
        ),
      );
      alternate = !alternate; // Alterna a cor na próxima linha
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            foregroundDecoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            // clipBehavior: Clip.hardEdge,
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              border: TableBorder(
                verticalInside: BorderSide(color: Colors.black, width: 0.5),
              ),
              children: rows,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Lista de perguntas da categoria Social
  List<String> _socialQuestions() {
    return [
      'A empresa possui políticas de diversidade e inclusão?',
      'A empresa compromete-se com a saúde e segurança dos funcionários?',
      'A empresa oferece oportunidades de desenvolvimento e capacitação para os empregados?',
      'A empresa engaja-se com as comunidades locais onde opera?',
      'A empresa promove igualdade de gênero no local de trabalho?',
      'A empresa possui práticas de remuneração e benefícios justas?',
      'A empresa possui políticas contra assédio e discriminação?',
      'A empresa contribui para a educação e formação profissional na comunidade?',
      'A empresa realiza auditorias sociais em sua cadeia de suprimentos?',
      'A empresa incentiva programas de voluntariado corporativo?',
      'A empresa apoia a saúde e o bem-estar dos funcionários além do local de trabalho?',
      'A empresa possui políticas contra trabalho infantil e trabalho forçado em sua cadeia de suprimentos?',
      'A empresa lida com questões de direitos humanos em suas operações globais?',
      'A empresa envolve os funcionários em decisões importantes que os afetam?',
      'A empresa possui uma alta taxa de retenção de funcionários?',
      'A empresa promove a participação dos funcionários em iniciativas de responsabilidade social?',
      'A empresa possui práticas transparentes de comunicação com as partes interessadas?',
      'A empresa mede e relata seu impacto social?',
      'A empresa apoia iniciativas culturais e esportivas nas comunidades onde atua?',
      'A empresa possui políticas de equilíbrio entre vida pessoal e profissional para os funcionários?',
    ];
  }

  // Lista de perguntas da categoria Governamental
  List<String> _governmentQuestions() {
    return [
      'A empresa possui uma política ambiental clara e documentada?',
      'A empresa possui metas de redução de emissões de carbono?',
      'A empresa gerencia adequadamente seus resíduos sólidos?',
      'A empresa utiliza fontes de energia renovável?',
      'Existem programas de eficiência energética implementados na empresa?',
      'A empresa realiza auditorias ambientais regulares?',
      'A empresa gerencia seu consumo de água de forma sustentável?',
      'A empresa possui políticas de reciclagem em vigor?',
      'A empresa lida adequadamente com a poluição do ar e da água gerada por suas operações?',
      'A empresa tem iniciativas para conservar a biodiversidade?',
      'A empresa oferece programas de educação ambiental para os funcionários?',
      'A empresa divulga seu desempenho ambiental em relatórios de sustentabilidade?',
      'A empresa investe em tecnologias limpas e sustentáveis?',
      'A empresa possui certificações ambientais, como ISO 14001?',
      'A empresa trabalha para minimizar o impacto ambiental ao longo de sua cadeia de suprimentos?',
      'A empresa avalia e mitiga o impacto ambiental de novos projetos?',
      'A empresa participa de iniciativas ou colaborações globais para a sustentabilidade ambiental?',
      'A empresa possui estratégias para lidar com as mudanças climáticas?',
      'A empresa incentiva práticas sustentáveis entre seus clientes e fornecedores?',
      'A empresa possui um compromisso com a restauração de ecossistemas afetados por suas operações?',
    ];
  }

  // Lista de perguntas da categoria Ambiental
  List<String> _environmentalQuestions() {
    return [
      'A empresa possui uma estratégia clara de sustentabilidade ambiental?',
      'A empresa integra considerações ambientais em seu planejamento estratégico?',
      'A empresa realiza auditorias ambientais regulares?',
      'A empresa possui práticas de gestão de risco ambiental?',
      'A empresa possui uma política de governança ambiental documentada?',
      'A empresa gerencia a conformidade com as leis e regulamentos ambientais?',
      'A empresa divulga relatórios de sustentabilidade ambiental?',
      'A empresa possui práticas de transparência em relação ao seu impacto ambiental?',
      'A empresa possui um comitê de sustentabilidade ou um departamento dedicado ao meio ambiente?',
      'A empresa lida com a responsabilidade ambiental na cadeia de suprimentos?',
      'A empresa promove a participação dos stakeholders nas decisões ambientais?',
      'A empresa tem políticas para prevenir e mitigar a poluição ambiental?',
      'A empresa gerencia e minimiza seu impacto ambiental ao longo do ciclo de vida dos produtos?',
      'A empresa possui programas de treinamento ambiental para os funcionários?',
      'A empresa possui estratégias para reduzir suas emissões de carbono?',
      'A empresa investe em tecnologias limpas e sustentáveis?',
      'A empresa mede e gerencia seu consumo de recursos naturais?',
      'A empresa divulga seu desempenho ambiental em relatórios públicos?',
      'A empresa possui práticas de responsabilidade ambiental em relação às comunidades locais?',
      'A empresa tem um histórico de iniciativas e projetos de conservação ambiental?',
    ];
  }
}
