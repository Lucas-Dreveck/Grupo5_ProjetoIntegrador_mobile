import 'package:ambiente_se/widgets/evaluation_widgets/evaluation_answer.dart';
import 'package:ambiente_se/widgets/evaluation_widgets/evaluations_questions_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultsPage extends StatelessWidget {
  final String companyName;
  final List<EvaluationAnswer> answers;

  const ResultsPage({Key? key, required this.companyName, required this.answers}) : super(key: key);

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
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPercentageRow(),
            const SizedBox(height: 20),
            _buildResultsCategory(EvaluationsQuestionsList.socialQuestions, const Color.fromRGBO(240, 135, 11, 1.0)),
            _buildResultsCategory(EvaluationsQuestionsList.governmentQuestions, const Color.fromRGBO(0, 113, 191, 1.0)),
            _buildResultsCategory(EvaluationsQuestionsList.environmentalQuestions, const Color.fromRGBO(106, 192, 74, 1.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPercentageAccordance('Social', 100, const Color.fromRGBO(240, 135, 11, 1.0)),
        _buildPercentageAccordance('Governamental', 100, const Color.fromRGBO(0, 119, 200, 1.0)),
        _buildPercentageAccordance('Ambiental', 100, const Color.fromRGBO(106, 192, 74, 1.0)),
      ],
    );
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
  Widget _buildResultsCategory(List<String> questions, Color color) {
    List<TableRow> rows = [
      _buildHeaderRow(),
    ];

    bool alternate = true; // Variável para alternar cores das linhas

    for (String question in questions) {
      final answer = answers.firstWhere((a) => a.question_registered == question, orElse: () => EvaluationAnswer(question_registered: question, answer_registered: 'N/A')); // Substitua 'N/A' por um valor padrão, se necessário
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
      child: Center(
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      height: 90,
    );
  }
}
