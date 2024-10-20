import 'dart:convert';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:ambiente_se/widgets/evaluation/finish_button.dart';
import 'package:ambiente_se/widgets/evaluation/questions.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation/next_page_button.dart';
import 'package:ambiente_se/widgets/evaluation/previous_page_button.dart';
import 'package:flutter/material.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({super.key});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _searchFieldKey = GlobalKey();
  final PageController _pageController = PageController();
  int currentPage = 0;
  List<Map<String, dynamic>> companies = [];
  Map<String, dynamic>? selectedCompany;
  bool isNewEvaluation = false;
  bool isDropdownOpen = false;
  double dropdownTop = 0.0;

  final Map<String, List<EvaluationAnswer>> _categoryAnswers = {
    'Social': [],
    'Governamental': [],
    'Ambiental': [],
  };

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      fetchCompanies(_searchController.text);
    } else {
      setState(() {
        companies = [];
        isDropdownOpen = false;
      });
    }
  }

  void _calculateDropdownPosition() {
    final RenderBox renderBox = _searchFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      dropdownTop = position.dy - renderBox.size.height;
    });
  }

  Future<void> fetchCompanies(String filter) async {
    final queryParams = {'name': filter.isEmpty ? 'a' : filter};
    const url = 'api/auth/Company/evaluation/search';
    
    try {
      final response = await makeHttpRequest(url, parameters: queryParams);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          companies = jsonResponse.map((company) => company as Map<String, dynamic>).toList();
          isDropdownOpen = true;
        });
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      print('Error fetching companies: $e');
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
              answer_registered: q['userAnswer'],
            )).toList();

            _categoryAnswers['Ambiental'] = environmentalQuestions.map((q) => EvaluationAnswer(
              question_id: q['questionId'].toString(),
              question_registered: q['questionDescription'],
              answer_registered: q['userAnswer'],
            )).toList();

            _categoryAnswers['Social'] = socialQuestions.map((q) => EvaluationAnswer(
              question_id: q['questionId'].toString(),
              question_registered: q['questionDescription'],
              answer_registered: q['userAnswer'],
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
        if (isComplete) {
          AlertSnackBar.show(
            context: context,
            text: 'Avaliação finalizada com sucesso',
            backgroundColor: AppColors.green,
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
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics:
          const NeverScrollableScrollPhysics(), // Desativa o deslizar manual
          children: [
            _buildCompanySelectionPage(),
            // Segunda página: Perguntas governamentais
            _buildGovernmentQuestionsPage(),
            // Terceira página: Perguntas ambientais
            _buildEnvironmentalQuestionsPage(),
            // Quarta página: Perguntas sociais
            _buildSocialQuestionsPage(),
         ],
        ),
      ),
    );
  }

  Widget _buildCompanySelectionPage() {
    return Stack(
      children: [
        Column(
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
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      key: _searchFieldKey,
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Buscar empresa...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                      ),
                      onTap: _calculateDropdownPosition,
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
        if (isDropdownOpen)
          Positioned(
            top: dropdownTop,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Material(
              elevation: 4.0,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(companies[index]['tradeName'] ?? ''),
                      onTap: () {
                        setState(() {
                          _searchController.removeListener(_onSearchChanged);
                          selectedCompany = companies[index];
                          _searchController.text = selectedCompany?['tradeName'] ?? '';
                          isDropdownOpen = false;
                          _searchController.addListener(_onSearchChanged);
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
      ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
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
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Iniciar nova avaliação',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
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
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Continuar avaliação',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                pageController: _pageController,
                label: 'Finalizar',
                companyName: selectedCompany?['tradeName'] ?? 'Nenhuma empresa selecionada',
                answers: _categoryAnswers,
              )
            ],
          ),
        ),
      ],
    );
  }
}