import 'package:flutter/material.dart';
import '../screens/home/pedido_compra.dart';
import '../screens/home/estoque_modal/estoque.dart';
import '../screens/home/config_screens/configuracoes.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final List<Widget> _pages = [
    EstoquePage(),
    PedidoCompraPage(),
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
              icon: Icon(Icons.view_list_rounded), label: 'Estoque'),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_rounded), label: 'Pedido de Compra'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Configurações'),
        ],
      ),
    );
  }
}
