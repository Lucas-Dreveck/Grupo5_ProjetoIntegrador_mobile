import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/custom_button.dart';
import 'package:ambiente_se/widgets/evaluation/evaluation_answer.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final Map<String, List<EvaluationAnswer>> answers;
  final Function(int) onSelectPage;
  final PageController pageController;
  final Future<void> Function(bool isComplete)? sendQuestions;
  final String label;

  const FinishButton({
    super.key,
    required this.answers,
    required this.onSelectPage,
    required this.pageController,
    this.sendQuestions,
    required this.label,
  });

  bool isAllQuestionsAnswered(Map<String, List<EvaluationAnswer>> answers) {
    for (var category in answers.values) {
      for (var answer in category) {
        if (answer.answer_registered == "") {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: AppColors.green,
      label: label,
      onPressed: () async {
        bool allAnswered = isAllQuestionsAnswered(answers);

        if (!allAnswered) {
          bool confirmFinish = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Atenção'),
                content: const Text('Você não respondeu todas as perguntas e não será possivel gerar o relatório final, deseja finalizar mesmo assim?'),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Finalizar avaliação'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );

          if (confirmFinish == true) {
            if (sendQuestions != null) {
              await sendQuestions!(false);
            }
            _navigateToResultsPage(context, false);
          }
        } else {
          if (sendQuestions != null) {
            await sendQuestions!(true); 
          }
          _navigateToResultsPage(context, true);
        }
      },
    );
  }

  void _navigateToResultsPage(BuildContext context, bool isFinished) {
    if (isFinished) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }

    onSelectPage(0);
  }
}
