import 'dart:async';
import 'dart:convert';
import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/default/new_register_button.dart';
import 'package:ambiente_se/widgets/default/default_search_bar.dart';
import 'package:ambiente_se/widgets/question/question_form.dart';
import 'package:ambiente_se/widgets/question/quest_view.dart';

class MainQuestionPage extends StatefulWidget {
  const MainQuestionPage({super.key});

  @override
  State<MainQuestionPage> createState() => MainQuestionPageState();
}

class MainQuestionPageState extends State<MainQuestionPage> {
  final List<Map<String, dynamic>> _questions = [];
  final TextEditingController _searchBarController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  String _searchText = '';
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 0;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadMoreQuestions();
    _scrollController.addListener(_onScroll);
    _searchBarController.addListener(_onSearchChanged);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreQuestions();
    }
  }

  void _onSearchChanged() {
    // Cancel previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // Start new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_searchBarController.text != _searchText) {
        _searchText = _searchBarController.text;
        _resetQuestions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchBarController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadMoreQuestions() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      const url = '/api/auth/Question/search';
      final Map<String, dynamic> parameters = {
        'page': _currentPage.toString(),
        'size': _itemsPerPage.toString(),
      };
      
      if (_searchText.isNotEmpty) {
        parameters['name'] = _searchText;
      }

      final response = await makeHttpRequest(context, url, parameters: parameters);

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> moreQuestions = List<Map<String, dynamic>>.from(
            json.decode(utf8.decode(response.bodyBytes)));

        if (moreQuestions.length < _itemsPerPage) {
          _hasMoreData = false;
        }

        if (mounted) {
          setState(() {
            _questions.addAll(moreQuestions);
            _currentPage++;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasMoreData = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasMoreData = false;
        });
      }
    }
  }

  Future<void> _resetQuestions() async {
    setState(() {
      _questions.clear();
      _currentPage = 0;
      _hasMoreData = true;
    });
    await _loadMoreQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Perguntas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DefaultSearchBar(
                    controller: _searchBarController, onSearch: () {},
                  ),
                ),
                const SizedBox(width: 16),
                NewRegisterButton(
                  label: "Novo Registro",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const QuestionRegistrationDialog(),
                    ).then((_) {
                      _resetQuestions();
                    });
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
              child: RefreshIndicator(
                onRefresh: _resetQuestions,
                child: _questions.isEmpty
                    ? const Center(
                        child: Text(
                          "Nenhuma pergunta encontrada",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                  width: constraints.maxWidth,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text('ID',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text('Pergunta',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: _questions.map(
                                      (item) => DataRow(
                                        cells: [
                                          DataCell(
                                            Center(
                                              child: Text((item['id']).toString(), textAlign: TextAlign.center),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => QuestionDetailDialog(
                                                  id: item['id'],
                                                ),
                                              ).then((_) {
                                                _resetQuestions();
                                              });
                                            },
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(item['description'], textAlign: TextAlign.center, maxLines: 2),
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => QuestionDetailDialog(
                                                  id: item['id'],
                                                ),
                                              ).then((_) {
                                                _resetQuestions();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ).toList(),
                                  ),
                                );
                              },
                            ),
                            if (_isLoading)
                              const CircularProgressIndicator()
                            else if (!_hasMoreData)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Fim da lista",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
