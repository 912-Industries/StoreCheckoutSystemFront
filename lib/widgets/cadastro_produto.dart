import 'package:flutter/material.dart';

class CadastroProduto extends StatefulWidget{
  @override
  _CadastroProduto createState() => _CadastroProduto();
}

class _CadastroProduto extends State<CadastroProduto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Layouts'),
          ),
          body: Column(
            children: const [
              Center(
                heightFactor: 2,
                child: Text(
                  'Olá Mundo!',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                  color: Colors.black,
                  )
                ),
              ),
            ]
          ),
        ),
    );
  }
}
