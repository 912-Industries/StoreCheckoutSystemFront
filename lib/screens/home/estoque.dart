import 'package:flutter/material.dart';

class EstoquePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              Text('ID'),
              Text('Nome'),
              Text('Preco'),
              Text('Categoria')
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
      ),
    );
  }
}
