import 'package:flutter/material.dart';
import 'package:store_checkout_system/widgets/bottom_nav_bar._widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to Home Page!'),
      ),
      bottomNavigationBar: MainPage(),
    );
  }
}
