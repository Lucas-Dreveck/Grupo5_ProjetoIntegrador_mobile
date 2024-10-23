import 'dart:async';
import 'dart:convert';
import 'package:ambiente_se/screens/employee/employee_details_page.dart';
import 'package:ambiente_se/screens/employee/employee_registration_page.dart';
import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/new_register_button.dart';
import 'package:ambiente_se/widgets/default/default_search_bar.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MainEmployeePage extends StatefulWidget {
  const MainEmployeePage({super.key});

  @override
  State<MainEmployeePage> createState() => MainEmployeePageState();
}

class MainEmployeePageState extends State<MainEmployeePage> with RouteAware {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchBarController = TextEditingController();
  final List<Map<String, dynamic>> _employees = [];
  Timer? _debounceTimer;
  String _searchText = '';
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 0;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadMoreEmployees();
    _scrollController.addListener(_onScroll);
    _searchBarController.addListener(_onSearchChanged);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreEmployees();
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
        _resetEmployees();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchBarController.dispose();
    _debounceTimer?.cancel();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _resetEmployees();
  }

  Future<void> _loadMoreEmployees() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      const url = '/api/auth/Employee/search';
      final Map<String, dynamic> parameters = {
        'page': _currentPage.toString(),
        'size': _itemsPerPage.toString(),
      };
      
      if (_searchText.isNotEmpty) {
        parameters['name'] = _searchText;
      }

      final response = await makeHttpRequest(url, parameters: parameters);

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> moreEmployees = List<Map<String, dynamic>>.from(
            json.decode(utf8.decode(response.bodyBytes)));

        if (moreEmployees.length < _itemsPerPage) {
          _hasMoreData = false;
        }

        if (mounted) {
          setState(() {
            _employees.addAll(moreEmployees);
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

  Future<void> _resetEmployees() async {
    setState(() {
      _employees.clear();
      _currentPage = 0;
      _hasMoreData = true;
    });
    await _loadMoreEmployees();
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
                  "Funcionários",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: DefaultSearchBar(
                    controller: _searchBarController,
                    onSearch: () {},
                  ),
                ),
                const SizedBox(width: 16),
                NewRegisterButton(
                  label: "Novo Registro",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeeRegistrationPage()),
                    );
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
                    onRefresh: _resetEmployees,
                    child: _employees.isEmpty
                        ? const Center(
                            child: Text("Nenhum funcionário encontrado",
                                style: TextStyle(fontSize: 18, color: Colors.red)))
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
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Nome ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Center(
                                                child: Text('Cargo',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: _employees
                                            .map(
                                              (item) => DataRow(
                                                cells: [
                                                  DataCell(
                                                    Center(
                                                      child: Text(
                                                          item['id'].toString(),
                                                          textAlign: TextAlign.center),
                                                    ),
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item['id']),
                                                        ),
                                                      );
                                                      if (result == true) {
                                                        _resetEmployees();
                                                      }
                                                    },
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Text(
                                                          item['name'].toString(),
                                                          textAlign: TextAlign.center),
                                                    ),
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item['id']),
                                                        ),
                                                      );
                                                      if (result == true) {
                                                        _resetEmployees();
                                                      }
                                                    },
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Text(
                                                          item['role']['description']
                                                              .toString(),
                                                          textAlign: TextAlign.center),
                                                    ),
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item['id']),
                                                        ),
                                                      );
                                                      if (result == true) {
                                                        _resetEmployees();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
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
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                          ))),
          ],
        ),
      ),
    );
  }
}