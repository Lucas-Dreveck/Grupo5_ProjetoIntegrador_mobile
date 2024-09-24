import 'package:ambiente_se/screens/company/company_registration_page.dart';
import 'package:ambiente_se/screens/company/company_details_page.dart';
import 'package:ambiente_se/widgets/default/new_register_button.dart';
import 'package:ambiente_se/widgets/default/search_button.dart';
import 'package:ambiente_se/widgets/default/default_search_bar.dart';
import 'package:flutter/material.dart';

class MainCompanyPage extends StatefulWidget {
  const MainCompanyPage({super.key});

  @override
  State<MainCompanyPage> createState() => MainCompanyPageState();
}

class MainCompanyPageState extends State<MainCompanyPage>{
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchBarController = TextEditingController();
  final List<Map<String, dynamic>> _companies = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadMoreCompanies(); 
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreCompanies(); 
      }
    });
  }


  Future<void> _loadMoreCompanies() async {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> moreCompanies = await fetchCompanies(_currentPage, _itemsPerPage);

    if (moreCompanies.length < _itemsPerPage) {
      _hasMoreData = false;
    }
    _hasMoreData = false;
    setState(() {
      _companies.addAll(moreCompanies);
      _currentPage++;
      _isLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> fetchCompanies(int page, int limit) async {
    await Future.delayed(const Duration(seconds: 2)); 
    return List.generate(limit, (index) {
      return {
        'id': (page - 1) * limit + index + 1,
        'nomeFantasia': 'Burguer King',
        'ramo': 'Alimentício',
      };
    });
    
  }

  Future<void> _resetCompanies() async {
    setState(() {
      _companies.clear();
      _currentPage = 1;
      _hasMoreData = true;
    });
    await _loadMoreCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empresas'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Empresas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                NewRegisterButton(label: "Novo Registro", onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompanyRegistrationPage()),
            );})
              ]
            ),
            const SizedBox(height: 15,),
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
              onRefresh: _resetCompanies,
              child: _companies.isEmpty
                ? const Center(child: Text("Nenhuma empresa encontrada", style: TextStyle(fontSize: 18, color: Colors.red)))
                :SingleChildScrollView(
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
                                      child: Text('ID', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text('Nome Fantasia', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text('Ramo', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                              rows: _companies.map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(item['id'].toString(), textAlign: TextAlign.center),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CompanyDetailsPage(id: item['id']),
                                          ),
                                        );
                                      },
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(item['nomeFantasia'], textAlign: TextAlign.center),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CompanyDetailsPage(id: item['id']),
                                          ),
                                        );
                                      },
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(item['ramo'], textAlign: TextAlign.center),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CompanyDetailsPage(id: item['id']),
                                          ),
                                        );
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
                )
              )
            ),
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