import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Field
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Buscar por nome",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Ranking General Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Container(
                      width: 400,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          ),
                          SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ranking Geral', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text('1ª Posição', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text('Biopark', style: TextStyle(fontSize: 22)),
                              Text('Ramo: Educacional', style: TextStyle(fontSize: 18, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Filters
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

                // Ranking Table Section
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                          rows: List<DataRow>.generate(
                            10,
                            (index) => DataRow(cells: [
                              DataCell(Text('${index + 1}º')),
                              DataCell(Text('Biopark')),
                              DataCell(Text('Educacional')),
                              DataCell(Text('Toledo')),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Pagination
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                    Text('Página 1'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
