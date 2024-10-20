import 'dart:convert';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:ambiente_se/widgets/evaluation/evaluations_questions_list.dart';
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

  void _saveAnswer(String category, String question, String answer) {
    final List<EvaluationAnswer> categoryAnswerList =
        _categoryAnswers[category]!;

    final existingAnswer = categoryAnswerList.firstWhere(
      (ans) => ans.question_registered == question,
      orElse: () => EvaluationAnswer(
          question_registered: question, answer_registered: answer),
    );

    setState(() {
      if (categoryAnswerList.contains(existingAnswer)) {
        existingAnswer.answer_registered = answer;
      } else {
        categoryAnswerList.add(EvaluationAnswer(
            question_registered: question, answer_registered: answer));
      }
    });
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
            // Segunda página: Perguntas sociais
            Column(
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
                    itemCount: EvaluationsQuestionsList.socialQuestions.length,
                    itemBuilder: (context, index) {
                      String savedAnswer = _categoryAnswers['Social']!
                          .firstWhere(
                            (ans) =>
                                ans.question_registered ==
                                EvaluationsQuestionsList.socialQuestions[index],
                            orElse: () => EvaluationAnswer(
                                question_registered: EvaluationsQuestionsList
                                    .socialQuestions[index],
                                answer_registered: ''),
                          )
                          .answer_registered;

                      return Questions(
                        question:
                            EvaluationsQuestionsList.socialQuestions[index],
                        onSelected: (answer) => _saveAnswer(
                            'Social',
                            EvaluationsQuestionsList.socialQuestions[index],
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
                        label: 'Próxima página',
                        width: 255,
                      )
                    ],
                  ),
                ),
              ],
            ),
// Terceira página: Perguntas governamentais
            Column(
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
                    itemCount:
                        EvaluationsQuestionsList.governmentQuestions.length,
                    itemBuilder: (context, index) {
                      String savedAnswer = _categoryAnswers['Governamental']!
                          .firstWhere(
                            (ans) =>
                                ans.question_registered ==
                                EvaluationsQuestionsList
                                    .governmentQuestions[index],
                            orElse: () => EvaluationAnswer(
                                question_registered: EvaluationsQuestionsList
                                    .governmentQuestions[index],
                                answer_registered: ''),
                          )
                          .answer_registered;

                      return Questions(
                        question:
                            EvaluationsQuestionsList.governmentQuestions[index],
                        onSelected: (answer) => _saveAnswer(
                            'Governamental',
                            EvaluationsQuestionsList.governmentQuestions[index],
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
                      NextPageButton(pageController: _pageController),
                    ],
                  ),
                ),
              ],
            ),
// Quarta página: Perguntas ambientais
            Column(
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
                    itemCount:
                        EvaluationsQuestionsList.environmentalQuestions.length,
                    itemBuilder: (context, index) {
                      String savedAnswer = _categoryAnswers['Ambiental']!
                          .firstWhere(
                            (ans) =>
                                ans.question_registered ==
                                EvaluationsQuestionsList
                                    .environmentalQuestions[index],
                            orElse: () => EvaluationAnswer(
                                question_registered: EvaluationsQuestionsList
                                    .environmentalQuestions[index],
                                answer_registered: ''),
                          )
                          .answer_registered;

                      return Questions(
                        question: EvaluationsQuestionsList
                            .environmentalQuestions[index],
                        onSelected: (answer) => _saveAnswer(
                            'Ambiental',
                            EvaluationsQuestionsList
                                .environmentalQuestions[index],
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
                        companyName: selectedCompany?['tradeName'] ??
                            'Nenhuma empresa selecionada',
                        answers: _categoryAnswers,
                      )
                    ],
                  ),
                ),
              ],
            ),
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

  void _onEvaluatePressed() async {
    if (selectedCompany != null) {
      bool hasActiveEvaluation = await verifyActiveEvaluation(selectedCompany!['id']);
      if (!hasActiveEvaluation) {
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
                        onPressed: () {
                          Navigator.of(context).pop();
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
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Implement logic to continue existing evaluation
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
  }