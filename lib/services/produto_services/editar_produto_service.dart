import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';

class EditarProdutoService {
  Future<bool>? editarProduto(
      String NomeProduto,
      double PrecoProdutoCusto,
      double PrecoProdutoFinal,
      String CategoriaProduto,
      String DescricaoProduto,
      int idProduto,
      int QuantidadeProduto) async {
    try {
      var response = await http.put(
          Uri.parse('http://localhost:8080/api/produto/editar/$idProduto'),
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
        EstoquePage.shouldRefreshData.value =
            true; // Atualize a lista de produtos após a edição
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Network error:  + $e');
      return false;
    }
  }

  Future<bool?> buscarQuantidadeProduto(int idProduto) async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:8080/api/produto/quantidade/$idProduto'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print('Network error:  + $e');
      return false;
    }
  }
}
