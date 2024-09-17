import 'package:ambiente_se/screens/empresa_screens/cadastro_empresa_page.dart';
import 'package:ambiente_se/screens/empresa_screens/empresa_page.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastrar_button.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_buscar_button.dart';
import 'package:ambiente_se/widgets/cadastro_widgets/cadastro_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListaEmpresasPage extends StatefulWidget {
  const ListaEmpresasPage({super.key});

  @override
  State<ListaEmpresasPage> createState() => _ListaEmpresasPageState();
}

class _ListaEmpresasPageState extends State<ListaEmpresasPage>{
  ScrollController _scrollController = ScrollController();
  final TextEditingController _searchBarController = TextEditingController();
  List<Map<String, dynamic>> _empresas = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _carregarMaisEmpresas(); // Carregar os primeiros itens
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _carregarMaisEmpresas(); // Carregar mais itens ao atingir o fim da lista
      }
    });
  }

  Future<void> _carregarMaisEmpresas() async {
    setState(() {
      _isLoading = true;
    });

    // Simulação do consumo do back-end
    List<Map<String, dynamic>> maisEmpresas =
        await fetchEmpresas(_currentPage, _itemsPerPage);

    setState(() {
      _empresas.addAll(maisEmpresas);
      _currentPage++;
      _isLoading = false;
    });
  }

  // Simulação de dados vindos do servidor
  Future<List<Map<String, dynamic>>> fetchEmpresas(int page, int limit) async {
    await Future.delayed(Duration(seconds: 2)); // Simulação de atraso
    return List.generate(limit, (index) {
      return {
        'id': (page - 1) * limit + index + 1,
        'razaoSocial': 'Burguer King',
        'ramo': 'Alimentício',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffFCFCFC),
      appBar: AppBar(
        title: Text("Aoba"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Empresas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                CadastrarButton(label: "Novo Registro", onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastroEmpresaPage()),
            );})
              ]
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: CadastroSearchBar(controller: _searchBarController, onSearch: (){}),),
                const SizedBox(width: 16,),
                CadastroBuscarButton(label: "Buscar", onPressed: (){})
              ],
            ),
            const SizedBox(height: 8,),
            const Divider(
              height: 15,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Expanded(child: Text('ID', textAlign: TextAlign.center))),
                        DataColumn(label: Expanded(child: Text('Razão Social', textAlign: TextAlign.center),)),
                        DataColumn(label: Expanded(child: Text('Ramo', textAlign: TextAlign.center),)),
                      ],
                        rows: _empresas
                          .map(
                          (item) => DataRow(
                            cells: [
                            DataCell(
                              Text(item['id'].toString(), textAlign: TextAlign.center),
                              onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => EmpresaPage(id: item['id']),
                                ),
                              );
                              },
                            ),
                            DataCell(
                              Text(item['razaoSocial'], textAlign: TextAlign.center),
                              onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => EmpresaPage(id: item['id']),
                                ),
                              );
                              },
                            ),
                            DataCell(
                              Text(item['ramo'], textAlign: TextAlign.center),
                              onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => EmpresaPage(id: item['id']),
                                ),
                              );
                              },
                            ),
                            ],
                          ),
                          )
                          .toList(),
                    ),
                    if (_isLoading) Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ],
        ),)
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}