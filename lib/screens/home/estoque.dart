import 'package:flutter/material.dart';

class EstoquePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Text('Ano'),
            Text('Linguagem'),
            Text('Autor'),
          ]),
          TableRow(children: [
            Text('2011'),
            Text('Dart'),
            Text('Lars Bak'),
          ]),
          TableRow(children: [
            Text('1996'),
            Text('Java'),
            Text('James Gosling'),
          ]),
        ],
      ),
    );
  }
}
