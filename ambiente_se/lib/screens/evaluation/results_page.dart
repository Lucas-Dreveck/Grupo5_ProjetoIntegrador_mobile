// ignore_for_file: unnecessary_const

import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:ambiente_se/widgets/evaluation/evaluations_questions_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultsPage extends StatelessWidget {
  final String companyName;
  final Map<String, List<EvaluationAnswer>> categoryAnswers; // Agora usa um Map de respostas categorizadas

  const ResultsPage({super.key, required this.companyName, required this.categoryAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPercentageRow(),
            const SizedBox(height: 20),
            _buildResultsCategory('Social', EvaluationsQuestionsList.socialQuestions, const Color.fromRGBO(240, 135, 11, 1.0)),
            _buildResultsCategory('Governamental', EvaluationsQuestionsList.governmentQuestions, const Color.fromRGBO(0, 113, 191, 1.0)),
            _buildResultsCategory('Ambiental', EvaluationsQuestionsList.environmentalQuestions, const Color.fromRGBO(106, 192, 74, 1.0)),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                // Ação simples: exibir um SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: const Text('Download iniciado!'), // Mensagem a ser exibida
                    duration: Duration(seconds: 2), // Duração do SnackBar
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Cor de fundo igual ao fundo
                foregroundColor: Colors.black, // Cor do texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
                  side: const BorderSide(
                    color: Color.fromRGBO(192, 188, 188, 1), // Cor da borda
                    width: 1.0, // Largura da borda
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Ajusta o padding para formar quase um quadrado
              ).copyWith(
                elevation: WidgetStateProperty.all(0), // Remove a sombra
              ),
              child: const Text(
                'Baixar',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 80,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 75,
            backgroundImage: AssetImage('images/logo.png'),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Resultados \n $companyName',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPercentageRow() {
    // Calcula a porcentagem de cada categoria com base nas respostas
    double socialPercentage = _calculatePercentage(EvaluationsQuestionsList.socialQuestions, categoryAnswers['Social']!);
    double governmentalPercentage = _calculatePercentage(EvaluationsQuestionsList.governmentQuestions, categoryAnswers['Governamental']!);
    double environmentalPercentage = _calculatePercentage(EvaluationsQuestionsList.environmentalQuestions, categoryAnswers['Ambiental']!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPercentageAccordance('Social', socialPercentage, const Color.fromRGBO(240, 135, 11, 1.0)),
        _buildPercentageAccordance('Governamental', governmentalPercentage, const Color.fromRGBO(0, 119, 200, 1.0)),
        _buildPercentageAccordance('Ambiental', environmentalPercentage, const Color.fromRGBO(106, 192, 74, 1.0)),
      ],
    );
  }

  // Função para calcular a porcentagem de conformidade com base nas respostas "Conforme"
  double _calculatePercentage(List<String> questions, List<EvaluationAnswer> answers) {
    if (questions.isEmpty) return 0;
    int conformeCount = answers.where((answer) => answer.answer_registered == 'Conforme').length;
    return (conformeCount / questions.length) * 100;
  }

  // Função para mostrar a porcentagem de conformidade por categoria com cor específica
  Widget _buildPercentageAccordance(String category, double percentage, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50,
          backgroundColor: const Color.fromRGBO(254, 247, 255, 1.0),
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
          style: const TextStyle(fontSize: 21, color: Colors.black),
        ),
      ],
    );
  }

  // Função para construir as seções de cada categoria com cor específica
  Widget _buildResultsCategory(String category, List<String> questions, Color color) {
    List<TableRow> rows = [
      _buildHeaderRow(),
    ];

    bool alternate = true; // Variável para alternar cores das linhas

    for (String question in questions) {
      final answer = categoryAnswers[category]?.firstWhere(
        (a) => a.question_registered == question,
        orElse: () => EvaluationAnswer(question_id: '', question_registered: question, answer_registered: 'N/A'),
      ) ?? EvaluationAnswer(question_id: '', question_registered: question, answer_registered: 'N/A'); // Substitua 'N/A' por um valor padrão, se necessário

      rows.add(
        TableRow(
          children: [
            _buildTableCell(question, color, alternate),
            _buildTableCell(answer.answer_registered, color, alternate),
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
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              border: const TableBorder(
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

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildHeaderCell('Perguntas'),
        _buildHeaderCell('Respostas'),
      ],
    );
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTableCell(String content, Color color, bool alternate) {
    return Container(
      color: alternate ? color.withOpacity(1.0) : color.withOpacity(0.5),
      padding: const EdgeInsets.all(12.0),
      height: 90,
      child: Center(
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
