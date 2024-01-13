import 'package:flutter/material.dart';

class IconeExclusao extends StatelessWidget {
  final String idProduto;
  final Function excluirProduto;

  IconeExclusao({required this.idProduto, required this.excluirProduto});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        excluirProduto(int.parse(idProduto));
      },
    );
  }
}
