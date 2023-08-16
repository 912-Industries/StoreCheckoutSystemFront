import 'package:flutter/material.dart';
import '/widgets/bottom_nav_bar.dart';
import '/screens/vendas/vendas.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to Home Page!'),
      ),
      
      bottomNavigationBar: BottomNavBar(),

    );
  }
}
