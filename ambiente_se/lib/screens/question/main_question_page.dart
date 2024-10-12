import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/default/new_register_button.dart';
import 'package:ambiente_se/widgets/default/search_button.dart';
import 'package:ambiente_se/widgets/default/default_search_bar.dart';
import 'package:ambiente_se/widgets/question/question_form.dart';
import 'package:ambiente_se/widgets/question/quest_view.dart';


class MainQuestionPage extends StatefulWidget {
  const MainQuestionPage({super.key});

  @override
  State<MainQuestionPage> createState() => MainQuestionPageState();
}

class MainQuestionPageState extends State<MainQuestionPage> {
  final TextEditingController _searchBarController = TextEditingController();
  final List<Map<String, dynamic>> _questions = List.generate(10, (index) {
    return {
      'id': index + 1,
      'pergunta': 'Quem vive sob a sombra da estátua?',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Perguntas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                NewRegisterButton(
                  label: "Novo Registro",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const QuestionRegistrationDialog(), // Ensure this class is defined
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DefaultSearchBar(
                    controller: _searchBarController,
                    onSearch: () {
                      // Implementar lógica de busca
                    },
                  ),
                ),
                const SizedBox(width: 16),
                SearchButton(
                  label: "Buscar",
                  onPressed: () {
                    // Implementar lógica de busca
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              height: 15,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Pergunta ${index + 1}'), // Exibe um texto genérico
                    leading: Text((index + 1).toString()), // Exibe o índice da pergunta
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => QuestionDetailDialog( // Certifique-se de que este nome está correto
                          axis: 'Eixo padrão', // Passa um valor padrão ou genérico
                          question: 'Detalhes da pergunta', // Passa um texto genérico
                          onDelete: () {
                            // Lógica para exclusão, se necessário
                            print('Pergunta excluída');
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}