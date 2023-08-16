import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.payments_rounded), label: 'Vendas'),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_rounded), label: 'Estoque'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded),label: 'Configurações'),
        ],
      ),
    );
  }
}
