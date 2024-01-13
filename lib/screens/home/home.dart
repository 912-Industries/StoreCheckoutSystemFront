import 'package:flutter/material.dart';
import 'package:store_checkout_system/widgets/bottom_nav_bar._widget.dart';

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
      bottomNavigationBar: MainPage(),
    );
  }
}
