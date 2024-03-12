import 'package:flutter/material.dart';
import 'screens/login.dart'; 

//TODO Crud Usuário e níveis de permissão
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDV',
      home: LoginScreen(),
    );
  }
}
