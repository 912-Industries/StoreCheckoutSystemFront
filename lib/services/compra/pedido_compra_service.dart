import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_checkout_system/screens/home/estoque_modal/estoque.dart';

//TODO Implementar Conexão Back e Front
class PedidoCompraService {
  Future<bool>? pedidoCompra(
      String NomeProduto,
      double PrecoProdutoCusto,
      double PrecoProdutoFinal,
      String CategoriaProduto,
      String DescricaoProduto,
      int idProduto,
      int QuantidadeProduto) async {
    try {
      var response = await http.put(
          Uri.parse('http://localhost:8080/api/produto/compra/$idProduto'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nome_produto': NomeProduto,
            'precoFinal_produto': PrecoProdutoFinal,
            'categoria_produto': CategoriaProduto,
            'descricao_produto': DescricaoProduto,
            'quantidade_produto': QuantidadeProduto,
            'precoCusto_produto': PrecoProdutoCusto,
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
