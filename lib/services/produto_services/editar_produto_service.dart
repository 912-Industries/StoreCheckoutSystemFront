import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';

class EditarProdutoService {
  Future<bool>? editarProduto(String NomeProduto, double PrecoProdutoCusto,
      String DescricaoProduto, int idProduto, int QuantidadeProduto) async {
    try {
      var response = await http.put(
          Uri.parse('http://localhost:8080/api/produto/editar/$idProduto'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "id_produto": idProduto,
            "id_precoProduto": {
              "precoCusto_precoProduto": PrecoProdutoCusto,
            },
            "nome_produto": NomeProduto,
            "descricao_produto": DescricaoProduto,
            "quantidade_produto": QuantidadeProduto
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
}
