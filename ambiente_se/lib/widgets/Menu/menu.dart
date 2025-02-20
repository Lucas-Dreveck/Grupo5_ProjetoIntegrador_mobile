import 'package:ambiente_se/screens/login/login.dart';
import 'package:ambiente_se/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MenuLateral extends StatelessWidget {
  final int selectedPageIndex;
  final Function(int) onSelectPage;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(); 

  const MenuLateral({
    super.key,
    required this.selectedPageIndex,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.blue,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ambientese.png'),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _createDrawerItem(
                    icon: Icons.home,
                    text: 'Home',
                    selected: selectedPageIndex == 0,
                    onTap: () {
                      onSelectPage(0);
                      Navigator.of(context).pop();
                    },
                  ),
                  _createDrawerItem(
                    icon: Icons.star,
                    text: 'Ranking',
                    selected: selectedPageIndex == 1,
                    onTap: () {
                      onSelectPage(1);
                      Navigator.of(context).pop();
                    },
                  ),
                  _createDrawerItem(
                    icon: Icons.business,
                    text: 'Empresas',
                    selected: selectedPageIndex == 2,
                    onTap: () {
                      onSelectPage(2);
                      Navigator.of(context).pop();
                    },
                  ),
                  _createDrawerItem(
                    icon: Icons.people,
                    text: 'Funcionários',
                    selected: selectedPageIndex == 3,
                    onTap: () {
                      onSelectPage(3);
                      Navigator.of(context).pop();
                    },
                  ),
                  _createDrawerItem(
                    icon: Icons.question_answer,
                    text: 'Perguntas',
                    selected: selectedPageIndex == 4,
                    onTap: () {
                      onSelectPage(4);
                      Navigator.of(context).pop();
                    },
                  ),
                  _createDrawerItem(
                    icon: Icons.assessment,
                    text: 'Avaliação',
                    selected: selectedPageIndex == 5,
                    onTap: () {
                      onSelectPage(5);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.arrow_back, color: Colors.white),
                    title: const Text('Voltar', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: TextButton.icon(
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: const Text('Sair', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await _secureStorage.delete(key: 'auth_token');
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      color: selected ? AppColors.darkBlue : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: selected ? const Color.fromARGB(255, 255, 255, 255) : Colors.white),
        title: Text(
          text,
          style: TextStyle(
            color: selected ? const Color.fromARGB(255, 255, 255, 255) : Colors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
