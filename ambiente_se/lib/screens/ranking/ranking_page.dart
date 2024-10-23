import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    fetchRankingData(null, null, null);
    fetchDropdownsData().then((value) => fetchRankingData(null, null, null));
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchDropdownsData() async {
    isLoading = true;
    final response = await makeHttpRequest("api/auth/Company", method: 'GET');

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

  Future<void> fetchRankingData(String? segment, String? companySize, String? tradeName) async {
    if (segment == null) {
    } else if (segment == "Sem filtro") {
      queryParams.remove('segment');
    } else {
      queryParams['segment'] = segment;
    }

    if (companySize == null) {
    } else if (companySize == "Sem filtro") {
      queryParams.remove('companySize');
    } else {
      queryParams['companySize'] = companySize;
    }

    if (tradeName == null) {
    } else if (tradeName.isEmpty) {
      queryParams.remove('tradeName');
    } else {
      queryParams['tradeName'] = tradeName;
    }

    final response = await makeHttpRequest("/api/ranking/score", method: 'GET', parameters: queryParams);

    try {
      if (response.statusCode == 200) {
        setState(() {
          rankings = json.decode(utf8.decode(response.bodyBytes));
        });

        if (flagInit && rankings.isNotEmpty) {
          flagInit = false;
          firstPlace = rankings[0];
        }
      } else {
        AlertSnackBar.show(
          context: context,
          text: "Erro ao carregar rankings.",
          backgroundColor: AppColors.red,
        );
        throw Exception('Failed to load rankings');
      }
    } catch (e) {
      AlertSnackBar.show(
        context: context,
        text: "Erro ao carregar rankings: ${e.toString()}",
        backgroundColor: AppColors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Campo de Busca
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Buscar por nome",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      fetchRankingData(null, null, value);
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Seção de Ranking Geral
                (firstPlace != null)
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Container(
                            width: 450,
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: OverflowBox(
                                      minWidth: 0.0,
                                      minHeight: 0.0,
                                      maxWidth: 150.0,
                                      maxHeight: 150.0,
                                      child: Image.network(
                                        rankings.isNotEmpty
                                            ? (rankings[0]['imageUrl'] ?? 'assets/images/trofeu.png')
                                            : 'assets/images/trofeu.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ranking Geral',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '1ª Posição',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      firstPlace['companyName'] ?? 'Nome não informado',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      'Ramo: ${firstPlace['segment'] ?? 'Segmento não informado'}',
                                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 4, 100, 190)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
                SizedBox(height: 40),

                // Filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                          ),
                          hint: Text("Filtrar por ramo", style: TextStyle(fontSize: 12)),
                          items: _segmentList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value as String,
                              child: Text(value, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            fetchRankingData(newValue, null, null);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                          ),
                          hint: Text("Filtrar por porte", style: TextStyle(fontSize: 12)),
                          items: _sizeCompanyList
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value as String,
                              child: Text(value, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            fetchRankingData(null, newValue, null);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Tabela de Rankings
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : (rankings.isNotEmpty)
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.maxWidth - 40),
                                  child: DataTable(
                                    columnSpacing: 20,
                                    columns: const [
                                      DataColumn(
                                          label: Text('Posição',
                                              style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Nome',
                                              style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Ramo',
                                              style: TextStyle(fontWeight: FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Cidade',
                                              style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                    rows: rankings
                                        .map<DataRow>(
                                          (ranking) => DataRow(cells: [
                                            DataCell(Text(
                                              ranking['ranking'].toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              
                                            ), 
                                            onTap: () {
                                              downloadReport(context, ranking['id']);
                                            },
                                            ),
                                            DataCell(Text(ranking['companyName'] ?? 'Nome não informado'), onTap: () {
                                              downloadReport(context, ranking['id']);
                                            }),
                                            DataCell(Text(ranking['segment'] ?? 'Segmento não informado'), onTap: () {
                                              downloadReport(context, ranking['id']);
                                            }),
                                            DataCell(Text(ranking['city'] ?? 'Cidade não informada'), onTap: () {
                                              downloadReport(context, ranking['id']);
                                            }),
                                          ],
                                           
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(child: Text("Nenhum resultado encontrado")),
              ],
            ),
          );
        },
      ),
    );
  }
}
