import 'package:ambiente_se/screens/evaluation/results_page.dart';
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

enum SelectCompany {
  selecionar('Selecionar empresa'),
  company1('Empresa1'),
  company2('Empresa2'),
  company3('Empresa3');

  const SelectCompany(this.label);
  final String label;
}

class _EvaluationPageState extends State<EvaluationPage> {
  final TextEditingController selectCompanyController = TextEditingController();
  SelectCompany? selectedCompany;
  final PageController _pageController = PageController();
  int currentPage = 0;

  // Map para armazenar respostas por categoria
  final Map<String, List<EvaluationAnswer>> _categoryAnswers = {
    'Social': [],
    'Governamental': [],
    'Ambiental': [],
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Função para salvar respostas categorizadas
  void _saveAnswer(String category, String question, String answer) {
    final List<EvaluationAnswer> categoryAnswerList = _categoryAnswers[category]!;

    final existingAnswer = categoryAnswerList.firstWhere(
      (ans) => ans.question_registered == question,
      orElse: () => EvaluationAnswer(question_registered: question, answer_registered: answer),
    );

    setState(() {
      if (categoryAnswerList.contains(existingAnswer)) {
        existingAnswer.answer_registered = answer;
      } else {
        categoryAnswerList.add(EvaluationAnswer(question_registered: question, answer_registered: answer));
      }
    });
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
            physics: const NeverScrollableScrollPhysics(), // Desativa o deslizar manual
            children: [
// Primeira página: Escolha da empresa
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
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
                          controller: selectCompanyController,
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
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              currentPage++;
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultsPage(
                                  companyName: selectedCompany?.label ?? 'Nenhuma empresa selecionada',
                                  categoryAnswers: _categoryAnswers,
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
                        String savedAnswer = _categoryAnswers['Social']!.firstWhere(
                          (ans) => ans.question_registered == EvaluationsQuestionsList.socialQuestions[index],
                          orElse: () => EvaluationAnswer(question_registered: EvaluationsQuestionsList.socialQuestions[index], answer_registered: ''),
                        ).answer_registered;

                        return Questions(
                          question: EvaluationsQuestionsList.socialQuestions[index],
                          onSelected: (answer) => _saveAnswer('Social', EvaluationsQuestionsList.socialQuestions[index], answer),
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
                      itemCount: EvaluationsQuestionsList.governmentQuestions.length,
                      itemBuilder: (context, index) {
                        String savedAnswer = _categoryAnswers['Governamental']!.firstWhere(
                          (ans) => ans.question_registered == EvaluationsQuestionsList.governmentQuestions[index],
                          orElse: () => EvaluationAnswer(question_registered: EvaluationsQuestionsList.governmentQuestions[index], answer_registered: ''),
                        ).answer_registered;

                        return Questions(
                          question: EvaluationsQuestionsList.governmentQuestions[index],
                          onSelected: (answer) => _saveAnswer('Governamental', EvaluationsQuestionsList.governmentQuestions[index], answer),
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
                      itemCount: EvaluationsQuestionsList.environmentalQuestions.length,
                      itemBuilder: (context, index) {
                        String savedAnswer = _categoryAnswers['Ambiental']!.firstWhere(
                          (ans) => ans.question_registered == EvaluationsQuestionsList.environmentalQuestions[index],
                          orElse: () => EvaluationAnswer(question_registered: EvaluationsQuestionsList.environmentalQuestions[index], answer_registered: ''),
                        ).answer_registered;

                        return Questions(
                          question: EvaluationsQuestionsList.environmentalQuestions[index],
                          onSelected: (answer) => _saveAnswer('Ambiental', EvaluationsQuestionsList.environmentalQuestions[index], answer),
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
                          companyName: selectedCompany?.label ?? 'Nenhuma empresa selecionada',
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
      ),
    );
  }
}
