import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final queryParams = <String, dynamic>{};

  List<dynamic> rankings = [];
  String searchQuery = "";
  var _segmentList = [];
  var _sizeCompanyList = [];
  bool flagInit = true;
  dynamic firstPlace;
  bool isLoading = true;
  bool hasMoreData = true; 
  int currentPage = 0;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchRankingData(true, null, null, null);
    fetchDropdownsData().then((value) => fetchRankingData(true, null, null, null));
    _scrollController.addListener(_onScroll);

  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50 && !isLoading && hasMoreData) {
      currentPage++;
      fetchRankingData(false, null, null, null);
    }
  }


  @override
  void dispose() {
    _scrollController.dispose(); 
    super.dispose();
  }

  fetchDropdownsData() async {
    isLoading = true;
    final response = await makeHttpRequest(context, "api/auth/Company", method: 'GET');

    try {
      if (response.statusCode == 200) {
        final dropdowns = json.decode(utf8.decode(response.bodyBytes));

        if (dropdowns.isNotEmpty) {
          setState(() {
            _segmentList = dropdowns.map((item) => item['segment']).toSet().toList();
            _sizeCompanyList = dropdowns.map((item) => item['companySize']).toSet().toList();
            _segmentList.insert(0, "Sem filtro");
            _sizeCompanyList.insert(0, "Sem filtro");
          });
        }
      } else {
        isLoading = false;
        AlertSnackBar.show(
          context: context,
          text: "Erro ao carregar dropdowns.",
          backgroundColor: AppColors.red,
        );
        throw Exception('Failed to load dropdowns');
      }
    } catch (e) {
      isLoading = false;
      AlertSnackBar.show(
        context: context,
        text: "Erro ao carregar dropdowns: ${e.toString()}",
        backgroundColor: AppColors.red,
      );
    }
    isLoading = false;
  }
  
  Future<void> fetchRankingData(bool isNewSearch, String? segment, String? companySize, String? tradeName) async {
  
  if (segment == "Sem filtro") {
    queryParams.remove('segment');
  } else if (segment != null) {
    queryParams['segment'] = segment;
  }

  if (companySize == "Sem filtro") {
    queryParams.remove('companySize');
  } else if (companySize != null) {
    queryParams['companySize'] = companySize;
  }

  if (tradeName == null || tradeName.isEmpty) {
    queryParams.remove('tradeName');
  } else {
    queryParams['tradeName'] = tradeName;
  }

  final String endpoint = "/api/ranking/score";
  final Map<String, String> queryParameters = {
    'page': currentPage.toString(),
    ...queryParams,
  };

  final response = await makeHttpRequest(context, endpoint, method: 'GET', parameters: queryParameters);


  if (response.statusCode == 200) {
    final List<dynamic> newRankings = json.decode(utf8.decode(response.bodyBytes));

    if (firstPlace == null) {
      setState(() {
        firstPlace = newRankings.firstWhere((ranking) => ranking['ranking'] == 1, orElse: () => null);
      });
    }

    setState(() {
      isLoading = false; 
      if(isNewSearch){
        rankings.clear();
        currentPage = 0;
      }
      if (newRankings.isEmpty) {
        hasMoreData = false;

      } else {

        final Set<int> existingIds = rankings.map<int>((r) => r['id'] as int).toSet();
        final List<dynamic> filteredRankings = newRankings.where((ranking) => !existingIds.contains(ranking['id'] as int)).toList();

        rankings.addAll(filteredRankings);
        rankings.sort((a, b) => a['ranking'].compareTo(b['ranking'])); 
      }
    });
  } else {
    setState(() {
      isLoading = false; 
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Campo de Busca
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Buscar por nome",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      fetchRankingData(true, null, null, value);
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Seção de Ranking Geral
                (firstPlace != null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: SizedBox(
                            width: 450,
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: OverflowBox(
                                      minWidth: 0.0,
                                      minHeight: 0.0,
                                      maxWidth: 150.0,
                                      maxHeight: 150.0,
                                      child: Image.asset(
                                        rankings.isNotEmpty
                                            ? (rankings[0]['imageUrl'] ?? 'assets/images/trofeu.png')
                                            : 'assets/images/trofeu.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Ranking Geral',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '1ª Posição',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      firstPlace['companyName'] ?? 'Nome não informado',
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      'Ramo: ${firstPlace['segment'] ?? 'Segmento não informado'}',
                                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 4, 100, 190)),
                                    ),
                                  ],
                                ),)
                                
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 40),

                // Filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                          ),
                          hint: const Text("Filtrar por ramo", style: TextStyle(fontSize: 12)),
                          items: _segmentList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value as String,
                              child: Text(value, style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            fetchRankingData(true,newValue, null, null);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                          ),
                          hint: const Text("Filtrar por porte", style: TextStyle(fontSize: 12)),
                          items: _sizeCompanyList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value as String,
                              child: Text(value, style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            fetchRankingData(true, null, newValue, null);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Tabela de Rankings
                rankings.isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.maxWidth - 40),
                                  child: DataTable(
                                    columnSpacing: 20,
                                    columns: const [
                                      DataColumn(label: Text('Posição', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Nome', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Ramo', style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Cidade', style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: rankings
                                        .map<DataRow>(
                                          (ranking) => DataRow(cells: [
                                            DataCell(Text(ranking['ranking'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)), onTap: () {
                                              downloadReport(context, ranking['companyName']);
                                            }),
                                            DataCell(Text(ranking['companyName'] ?? 'Nome não informado'), onTap: () {
                                              downloadReport(context, ranking['companyName']);
                                            }),
                                            DataCell(Text(ranking['segment'] ?? 'Segmento não informado'), onTap: () {
                                              downloadReport(context, ranking['companyName']);
                                            }),
                                            DataCell(Text(ranking['city'] ?? 'Cidade não informada'), onTap: () {
                                              downloadReport(context, ranking['companyName']);
                                            }),
                                          ]),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(child: Text("Nenhum resultado encontrado")),
                        if (isLoading)
                          const CircularProgressIndicator()
                        else if (!hasMoreData)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Fim da lista",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          
          ],
            ),
          );
        },
      ),
    );
  }
}
