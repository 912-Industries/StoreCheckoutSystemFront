import 'package:flutter/material.dart';

class IconeExclusao extends StatelessWidget {
  final String idProduto;
  final Function excluirProduto;

  const IconeExclusao(
      {super.key, required this.idProduto, required this.excluirProduto});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        excluirProduto(int.parse(idProduto));
      },
    );
  }
}
