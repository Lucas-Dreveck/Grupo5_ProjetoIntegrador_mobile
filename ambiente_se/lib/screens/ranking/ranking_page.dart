import 'package:ambiente_se/utils.dart';
import 'package:ambiente_se/widgets/default/alert_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Importa para usar Timer

class RankingEmpresaPage extends StatefulWidget {
  const RankingEmpresaPage({Key? key}) : super(key: key);

  @override
  State<RankingEmpresaPage> createState() => _RankingEmpresaPageState();
}

class _RankingEmpresaPageState extends State<RankingEmpresaPage> {
  List<dynamic> rankings = [];
  String searchQuery = "";
  Timer? _debounce; // Timer para debounce

  @override
  void initState() {
    super.initState();
    fetchRankingData(); // Carrega rankings inicialmente
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancela o Timer se existir
    super.dispose();
  }

  Future<void> fetchRankingData() async {
    final response = await makeHttpRequest("/api/ranking/score", method: 'GET');
    if (response.statusCode == 200) {
      setState(() {
        rankings = json.decode(utf8.decode(response.bodyBytes));
      });
    } else {
      AlertSnackBar.show(
        context: context,
        text: "Erro ao carregar rankings.",
        backgroundColor: AppColors.red,
      );
      throw Exception('Failed to load rankings');
    }
  }
Future<void> fetchFilteredRankingData(String segment, String companySize, String tradeName) async {
  try {
    // Montando os parâmetros da query
    final queryParams = {
      if (segment.isNotEmpty) 'segment': segment,
      if (companySize.isNotEmpty) 'companySize': companySize,
      if (tradeName.isNotEmpty) 'tradeName': tradeName,
    };

    // Montando a URL com os parâmetros
    final uri = Uri.http("/api/ranking/score");

    final response = await makeHttpRequest(uri.toString(), method: 'GET', parameters: queryParams);

    if (response.statusCode == 200) {
      setState(() {
        rankings = json.decode(utf8.decode(response.bodyBytes));
      });
    } else {
      AlertSnackBar.show(
        context: context,
        text: "Erro ao carregar rankings filtrados. Código: ${response.statusCode}",
        backgroundColor: AppColors.red,
      );
    }
  } catch (e) {
    AlertSnackBar.show(
      context: context,
      text: "Erro ao carregar rankings filtrados: ${e.toString()}",
      backgroundColor: AppColors.red,
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.lightbulb, color: Colors.yellowAccent),
          ],
        ),
      ),
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
                      // Atualiza a consulta de busca
                      searchQuery = value; 

                      // Inicia o debounce
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 300), () {
                        fetchFilteredRankingData(value); // Chama a função de busca filtrada
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Seção de Ranking Geral
                if (rankings.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Container(
                        width: 450,
                        height: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 160, // Tamanho do círculo
                              height: 160, // Tamanho do círculo
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(0, 255, 255, 255), // Cor de fundo, se necessário
                              ),
                              child: ClipOval(
                                child: OverflowBox(
                                  minWidth: 0.0,
                                  minHeight: 0.0,
                                  maxWidth: 150.0,
                                  maxHeight: 150.0,
                                  child: Image.network(
                                    rankings[0]['imageUrl'] ?? 'assets/images/trofeu.png',
                                    fit: BoxFit.fill, // Use BoxFit.fill para esticar a imagem
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
                                  rankings[0]['companyName'] ?? 'Nome não informado',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  'Ramo: ${rankings[0]['segment'] ?? 'Segmento não informado'}',
                                  style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 4, 100, 190)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 40),

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
                          items: ['Ramo 1', 'Ramo 2']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
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
                          items: ['Porte 1', 'Porte 2']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Seção da Tabela de Ranking
                rankings.isNotEmpty
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
                                rows: rankings.map((ranking) {
                                  return DataRow(cells: [
                                    DataCell(Text('${ranking['ranking'] ?? '0'}º')),
                                    DataCell(Text(ranking['companyName'] ?? 'Nome não informado')),
                                    DataCell(Text(ranking['segment'] ?? 'Segmento não informado')),
                                    DataCell(Text(ranking['city'] ?? 'Cidade não informada')),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
