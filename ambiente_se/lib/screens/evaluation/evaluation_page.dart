import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation/questions.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/evaluation/finish_button.dart';
import 'package:ambiente_se/widgets/evaluation/next_page_button.dart';
import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:ambiente_se/widgets/evaluation/previous_page_button.dart';

class EvaluationPage extends StatefulWidget {
  final Function(int) onSelectPage;


  const EvaluationPage({
    super.key,
    required this.onSelectPage,
  });
  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  // Controllers
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
  int currentPage = 0;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final FocusNode _focusNode = FocusNode();

  // Variables
  List<Map<String, dynamic>> companies = [];
  Map<String, dynamic>? selectedCompany;
  bool isNewEvaluation = false;
  bool _isUpdatingTextField = false;

  int socialScore = 0;
  int governmentalScore = 0;
  int environmentalScore = 0;

  final Map<String, List<EvaluationAnswer>> _categoryAnswers = {
    'Social': [],
    'Governamental': [],
    'Ambiental': [],
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _pageController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _hideOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _selectFirstCompany() {
    if (companies.isNotEmpty) {
      _selectCompany(companies.first);
    }
  }

  void _selectCompany(Map<String, dynamic> company) {
    _isUpdatingTextField = true;
    setState(() {
      selectedCompany = company;
      _searchController.text = company['tradeName'] ?? '';
    });
    _hideOverlay();
    Future.microtask(() {
      _focusNode.unfocus();
      _isUpdatingTextField = false;
    });
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          width: 300,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0.0, 55.0),
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                  minHeight: 50,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(companies[index]['tradeName'] ?? ''),
                      onTap: () {
                        _selectCompany(companies[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _onSearchChanged() {
    if (!_isUpdatingTextField) {
      if (_searchController.text.isEmpty) {
        setState(() {
          companies = [];
        });
      }
      fetchCompanies(_searchController.text);
    }
  }

  Future<void> fetchCompanies(String filter) async {
    final queryParams = {'name': filter};
    const url = 'api/auth/Company/evaluation/search';
    
    try {
      final response = await makeHttpRequest(url, parameters: queryParams);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          companies = jsonResponse.map((company) => company as Map<String, dynamic>).toList();
        });
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      print('Error fetching companies: $e');
    } finally {
      if (mounted) {
        _showOverlay();
      }
    }
  }

  Future<bool> verifyActiveEvaluation(int companyId) async {
    final url = 'api/auth/haveActiveEvaluation/$companyId';
    
    try {
      final response = await makeHttpRequest(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to verify active evaluation');
      }
    } catch (e) {
      print('Error verifying active evaluation: $e');
      return false;
    }
  }

  Future<void> fetchQuestions() async {
    final url = 'api/auth/evaluation/$isNewEvaluation';
    final queryParams = {'companyId': selectedCompany!['id'].toString()};

    try {
      final response = await makeHttpRequest(url, parameters: queryParams);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (isNewEvaluation && data['questions'] is List) {
          List<Map<String, dynamic>> governmentQuestions = [];
          List<Map<String, dynamic>> environmentalQuestions = [];
          List<Map<String, dynamic>> socialQuestions = [];

          for (var item in data['questions']) {
            if (item['pillar'] is String) {
              switch (item['pillar']) {
                case 'Governamental':
                  governmentQuestions.add(item);
                  break;
                case 'Ambiental':
                  environmentalQuestions.add(item);
                  break;
                case 'Social':
                  socialQuestions.add(item);
                  break;
              }
            } else {
              print('Unexpected pillar type: ${item['pillar']}');
            }
          }

          setState(() {
            _categoryAnswers['Governamental'] = governmentQuestions.map((q) => EvaluationAnswer(
              question_id: q['id'].toString(),
              question_registered: q['description'],
              answer_registered: '',
            )).toList();

            _categoryAnswers['Ambiental'] = environmentalQuestions.map((q) => EvaluationAnswer(
              question_id: q['id'].toString(),
              question_registered: q['description'],
              answer_registered: '',
            )).toList();

            _categoryAnswers['Social'] = socialQuestions.map((q) => EvaluationAnswer(
              question_id: q['id'].toString(),
              question_registered: q['description'],
              answer_registered: '',
            )).toList();
          });

        } else if (!isNewEvaluation && data['evaluationRequests'] is List) {
          List<Map<String, dynamic>> governmentQuestions = [];
          List<Map<String, dynamic>> environmentalQuestions = [];
          List<Map<String, dynamic>> socialQuestions = [];

          for (var item in data['evaluationRequests']) {
            if (item['questionPillar'] is String) {
              switch (item['questionPillar']) {
                case 'Governamental':
                  governmentQuestions.add(item);
                  break;
                case 'Ambiental':
                  environmentalQuestions.add(item);
                  break;
                case 'Social':
                  socialQuestions.add(item);
                  break;
              }
            } else {
              print('Unexpected questionPillar type: ${item['questionPillar']}');
            }
          }

          setState(() {
            _categoryAnswers['Governamental'] = governmentQuestions.map((q) => EvaluationAnswer(
              question_id: q['questionId'].toString(),
              question_registered: q['questionDescription'],
              answer_registered: q['userAnswer'] ?? '',
            )).toList();

            _categoryAnswers['Ambiental'] = environmentalQuestions.map((q) => EvaluationAnswer(
              question_id: q['questionId'].toString(),
              question_registered: q['questionDescription'],
              answer_registered: q['userAnswer'] ?? '',
            )).toList();

            _categoryAnswers['Social'] = socialQuestions.map((q) => EvaluationAnswer(
              question_id: q['questionId'].toString(),
              question_registered: q['questionDescription'],
              answer_registered: q['userAnswer'] ?? '',
            )).toList();
          });
        } else {
          print('Error: Expected a list in questions or evaluationRequests');
        }

      } else {
        throw Exception('Erro ao carregar perguntas');
      }
    } catch (e) {
      print('Erro ao buscar perguntas: $e');
    }
  }

  void _saveAnswer(String category, String question, String answer) {
    final List<EvaluationAnswer> categoryAnswerList =
        _categoryAnswers[category]!;

    final existingAnswer = categoryAnswerList.firstWhere(
      (ans) => ans.question_registered == question
    );

    setState(() {
      existingAnswer.answer_registered = answer;
    });
  }

  Future<void> _sendQuestions(bool isComplete) async {
    final String? companyId = selectedCompany?['id'].toString();
    if (companyId == null) {
      return;
    }
    final List<Map<String, dynamic>> answers = [];

    for (var category in _categoryAnswers.keys) {
      for (var answer in _categoryAnswers[category]!) {
        answers.add({
          'questionId': answer.question_id,
          'userAnswer': answer.answer_registered != '' ? answer.answer_registered : null,
          'questionPillar': category,
        });
      }
    }

    final body = answers;
    final queryParams = {'companyId': companyId, 'isComplete': isComplete.toString()};
    const url = "api/auth/processAnswers";

    try {
      final response = await makeHttpRequest(url, method: 'POST', parameters: queryParams, body: json.encode(body));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (isComplete) {
          setState(() {
            socialScore = jsonResponse['socialScore'];
            governmentalScore = jsonResponse['governmentScore'];
            environmentalScore = jsonResponse['enviornmentalScore'];
          });
          AlertSnackBar.show(
            context: context,
            text: 'Avaliação finalizada com sucesso',
            backgroundColor: AppColors.green,
            duration: 2,
          );
        } else {
          AlertSnackBar.show(
            context: context,
            text: 'Respostas salvas com sucesso',
            backgroundColor: AppColors.green,
            duration: 1,
          );
        }
      } else {
        throw Exception('Failed to save answers');
      }
    } catch (e) {
      print('Error saving answers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
        _hideOverlay();
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics:
            const NeverScrollableScrollPhysics(),
            children: [
              _buildCompanySelectionPage(),
              _buildGovernmentQuestionsPage(),
              _buildEnvironmentalQuestionsPage(),
              _buildSocialQuestionsPage(),
              _buildResultPage(),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanySelectionPage() {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Escolha a empresa para a avaliação',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CompositedTransformTarget(
                  link: _layerLink,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Buscar empresa...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _selectFirstCompany(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            label: 'Avaliar',
            onPressed: selectedCompany != null ? _onEvaluatePressed : null,
          ),
        ],
      ),
    );
  }

  Future<void> _onEvaluatePressed() async {
    if (selectedCompany != null) {
      bool hasActiveEvaluation = await verifyActiveEvaluation(selectedCompany!['id']);
      if (!hasActiveEvaluation) {
        isNewEvaluation = true;
        await fetchQuestions();
        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        setState(() {
          currentPage++;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                child: Text('Atenção', textAlign: TextAlign.center),
              ),
              content: const Text(
                'A empresa selecionada já possui uma avaliação em andamento. Deseja iniciar uma nova avaliação ou continuar a avaliação existente?',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        isNewEvaluation = true;
                        await fetchQuestions();
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                        setState(() {
                          currentPage++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Iniciar nova avaliação',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        isNewEvaluation = false;
                        await fetchQuestions();
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                        setState(() {
                          currentPage++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        'Continuar avaliação',
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma empresa antes de avançar')),
      );
    }
  }

  Widget _buildGovernmentQuestionsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Align(
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
          child: ListView.builder(
            itemCount: _categoryAnswers['Governamental']!.length,
            itemBuilder: (context, index) {
              String savedAnswer = _categoryAnswers['Governamental']![index].answer_registered;
              String question = _categoryAnswers['Governamental']![index].question_registered;

              return Questions(
                question: question,
                onSelected: (answer) => _saveAnswer(
                    'Governamental',
                    question,
                    answer),
                selectedOption: savedAnswer,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NextPageButton(
                pageController: _pageController,
                sendQuestions: () => _sendQuestions(false),
                label: 'Próxima página',
                width: 255,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnvironmentalQuestionsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Align(
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
          child: ListView.builder(
            itemCount: _categoryAnswers['Ambiental']!.length,
            itemBuilder: (context, index) {
              String savedAnswer = _categoryAnswers['Ambiental']![index].answer_registered;
              String question = _categoryAnswers['Ambiental']![index].question_registered;

              return Questions(
                question: question,
                onSelected: (answer) => _saveAnswer(
                    'Ambiental',
                    question,
                    answer),
                selectedOption: savedAnswer,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PreviousPageButton(pageController: _pageController),
              const SizedBox(width: 50),
              NextPageButton(sendQuestions: () => _sendQuestions(false), pageController: _pageController),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialQuestionsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Align(
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
          child: ListView.builder(
            itemCount: _categoryAnswers['Social']!.length,
            itemBuilder: (context, index) {
              String savedAnswer = _categoryAnswers['Social']![index].answer_registered;
              String question = _categoryAnswers['Social']![index].question_registered;

              return Questions(
                question: question,
                onSelected: (answer) => _saveAnswer(
                    'Social',
                    question,
                    answer),
                selectedOption: savedAnswer,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PreviousPageButton(pageController: _pageController),
              const SizedBox(width: 50),
              FinishButton(
                onSelectPage: (int index) => widget.onSelectPage(index),
                pageController: _pageController,
                sendQuestions: (bool isComplete) => _sendQuestions(isComplete),
                label: 'Finalizar',
                answers: _categoryAnswers,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultPage() {
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
            _buildResultsCategory('Social', AppColors.socialPillar),
            _buildResultsCategory('Governamental', AppColors.governmentPillar),
            _buildResultsCategory('Ambiental', AppColors.environmentalPillar),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    await downloadReport(context, selectedCompany!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(
                        color: Color.fromRGBO(192, 188, 188, 1),
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ).copyWith(
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: const Text(
                    'Baixar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSelectPage(0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(
                        color: Color.fromRGBO(192, 188, 188, 1),
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ).copyWith(
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: const Text(
                    'Voltar a tela principal',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
          'Resultados \n ${selectedCompany?['tradeName'] ?? 'Nenhuma empresa selecionada'}',
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
        _buildPercentageAccordance('Social', socialScore, AppColors.socialPillar),
        _buildPercentageAccordance('Governamental', governmentalScore, const Color.fromRGBO(0, 119, 200, 1.0)),
        _buildPercentageAccordance('Ambiental', environmentalScore, AppColors.environmentalPillar),
      ],
    );
  }

  Widget _buildPercentageAccordance(String category, int percentage, Color color) {
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
            '$percentage%',
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

  Widget _buildResultsCategory(String category, Color color) {
    List<TableRow> rows = [
      _buildHeaderRow(),
    ];

    bool alternate = true;

    for (var answer in _categoryAnswers[category]!) {
      rows.add(
        TableRow(
          children: [
            _buildTableCell(answer.question_registered, color, alternate),
            _buildTableCell(answer.answer_registered, color, alternate),
          ],
        ),
      );
      alternate = !alternate;
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