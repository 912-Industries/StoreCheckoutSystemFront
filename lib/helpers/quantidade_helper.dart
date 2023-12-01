import 'package:flutter/material.dart';

class QuantidadeHelper {
  static int aumentarQuantidade(
      int quantidade, TextEditingController quantidadeProdutoController) {
    quantidade++;
    quantidadeProdutoController.text = quantidade.toString();
    return quantidade;
  }

  static int diminuirQuantidade(
      int quantidade, TextEditingController quantidadeProdutoController) {
    if (quantidade > 0) {
      quantidade--;
      quantidadeProdutoController.text = quantidade.toString();
    }
    return quantidade;
  }
}
