import 'package:flutter/material.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/listagem_usuario.dart';
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';
import 'package:store_checkout_system/screens/home/config_screens/configuracoes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final List<Widget> _pages = [
    const ControleUsuarioPage(),
    const EstoquePage(),
    const ConfiguracaoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded), label: 'Usuários'),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_rounded), label: 'Estoque'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Configurações'),
        ],
      ),
    );
  }
}
