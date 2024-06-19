import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';

class PedidoCompraService {
  Future<bool>? pedidoCompra(
      int idProduto,
      String nomeProduto,
      double precoCustoProduto,
      double precoFinalProduto,
      String descricaoProduto,
      int quantidadeProduto) async {
    try {
      var response = await http.put(
          Uri.parse('http://localhost:8080/api/produto/compra/$idProduto'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'id_produto': idProduto,
            'nome_produto': nomeProduto,
            'precoCusto_produto': precoCustoProduto,
            'descricao_produto': descricaoProduto,
            'quantidade_produto': quantidadeProduto
          }));

      if (response.statusCode == 200) {
        EstoquePage.shouldRefreshData.value = true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Network error : + $e');
      return false;
    }
  }
}
