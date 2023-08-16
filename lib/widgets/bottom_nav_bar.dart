import 'package:flutter/material.dart';
import '/screens/home/vendas.dart';
import '/screens/home/estoque.dart';
import '/screens/home/configuracoes.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    VendasPage(),
    EstoquePage(),
    ConfiguracaoPage(),
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
              icon: Icon(Icons.payments_rounded), label: 'Vendas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded), label: 'Estoque'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Configurações'),
        ],
      ),
    );
  }
}
