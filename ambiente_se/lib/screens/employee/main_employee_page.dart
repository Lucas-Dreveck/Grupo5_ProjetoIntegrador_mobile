import 'package:ambiente_se/screens/company/company_details_page.dart';
import 'package:ambiente_se/screens/employee/employee_details_page.dart';
import 'package:ambiente_se/screens/employee/employee_registration_page.dart';
import 'package:ambiente_se/widgets/default/new_register_button.dart';
import 'package:ambiente_se/widgets/default/search_button.dart';
import 'package:ambiente_se/widgets/default/default_search_bar.dart';
import 'package:flutter/material.dart';

class MainEmployeePage extends StatefulWidget {
  const MainEmployeePage({super.key});

  @override
  State<MainEmployeePage> createState() => MainEmployeePageState();
}

class MainEmployeePageState extends State<MainEmployeePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchBarController = TextEditingController();
  final List<Map<String, dynamic>> _employees = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadMoreEmployees();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreEmployees();
      }
    });
  }

  Future<void> _loadMoreEmployees() async {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> moreEmployees =
        await fetchEmployees(_currentPage, _itemsPerPage);

    if (moreEmployees.length < _itemsPerPage) {
      _hasMoreData = false;
    }
    _hasMoreData = false;
    setState(() {
      _employees.addAll(moreEmployees);
      _currentPage++;
      _isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> fetchEmployees(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(limit, (index) {
      return {
        'id': (page - 1) * limit + index + 1,
        'Nome': 'Lucas Costa',
        'Cargo': 'Gestor',
      };
    });
  }

  Future<void> _resetEmployees() async {
    setState(() {
      _employees.clear();
      _currentPage = 1;
      _hasMoreData = true;
    });
    await _loadMoreEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Funcionários'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [
              const Text(
                "Funcionários",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Expanded(child: SizedBox()),
              NewRegisterButton(
                  label: "Novo Registro",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const EmployeeRegistrationPage()),
                    );
                  })
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DefaultSearchBar(
                    controller: _searchBarController,
                    onSearch: () {},
                  ),
                ),
                const SizedBox(width: 16),
                SearchButton(
                  label: "Buscar",
                  onPressed: () {},
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
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)))
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
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item[
                                                                      'id']),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Text(
                                                          item['Nome'],
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item[
                                                                      'id']),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Text(item['Cargo'],
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetailsPage(
                                                                  id: item[
                                                                      'id']),
                                                        ),
                                                      );
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
