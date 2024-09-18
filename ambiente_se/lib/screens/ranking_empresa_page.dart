import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RankingEmpresaPage(),
    );
  }
}

class RankingEmpresaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.04),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ranking Geral', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text('1ª Posição', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text('Biopark', style: TextStyle(fontSize: 18)),
                                Text('Ramo: Educacional', style: TextStyle(fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row contents
                    children: [
                      SizedBox(
                        width: 150, // Fixed width for the dropdown
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0), // Reduzido para ajustar o padding interno
                          ),
                          hint: Text("Filtrar por ramo", style: TextStyle(fontSize: 12)), // Reduzido o tamanho do texto
                          items: ['Ramo 1', 'Ramo 2']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12)), // Reduzido o tamanho do texto
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ),
                      SizedBox(width: 10), // Increased space between dropdowns
                      SizedBox(
                        width: 150, // Fixed width for the dropdown
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0), // Reduzido para ajustar o padding interno
                          ),
                          hint: Text("Filtrar por porte", style: TextStyle(fontSize: 12)), // Reduzido o tamanho do texto
                          items: ['Porte 1', 'Porte 2']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(fontSize: 12)), // Reduzido o tamanho do texto
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
