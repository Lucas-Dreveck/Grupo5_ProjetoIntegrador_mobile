import 'package:flutter/material.dart';
import 'package:ambiente_se/widgets/Menu/menu.dart'; // Importe o MenuLateral

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmbienteSE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AmbienteSE'),
      ),
      drawer: MenuLateral(),
      body: Center(
        child: Text('Bem-vindo ao AmbienteSE'),
      ),
    );
  }
}
