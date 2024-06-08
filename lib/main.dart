import 'package:flutter/material.dart';
import 'screens/login.dart';

//TODO Crud Usuário e níveis de permissão
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDV',
      home: LoginScreen(),
    );
  }
}
