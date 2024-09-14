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
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o título na AppBar
          children: [
            Icon(Icons.lightbulb, color: Colors.yellowAccent),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center( // Envolve o conteúdo principal em um widget Center
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Buscar por nome",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Ranking General Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50, // Define the size of the circle
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ranking Geral', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text('1ª Posição', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Biopark', style: TextStyle(fontSize: 18)),
                        Text('Ramo: Educacional', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Filters
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Filtrar por ramo"),
                        items: ['Ramo 1', 'Ramo 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {},
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: Text("Filtrar por porte"),
                        items: ['Porte 1', 'Porte 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Ranking Table Section
              DataTable(
                columns: const [
                  DataColumn(label: Text('Posição')),
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Ramo')),
                  DataColumn(label: Text('Cidade')),
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
              SizedBox(height: 20),

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
        ),
      ),
    );
  }
}
