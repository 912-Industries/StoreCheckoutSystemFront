import 'dart:convert';
import 'package:http/http.dart' as http;

class EditarProdutoService {
  Future<bool>? editarProduto(
      String NomeProduto,
      double PrecoProdutoFinal,
      double PrecoProdutoCusto,
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
            'precoCusto_produto': PrecoProdutoCusto,
            'categoria_produto': CategoriaProduto,
            'descricao_produto': DescricaoProduto,
            'quantidade_produto': QuantidadeProduto
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Network error:  + $e');
      return false;
    }
  }

  Future<int?> buscarQuantidadeProduto(int idProduto) async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:8080/api/produto/quantidade/$idProduto'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Network error:  + $e');
      return null;
    }
  }

  Future<int?> aumentarQuantidade(int idProduto) async {
    try {
      var response = await http.put(
          Uri.parse(
              'http://localhost:8080/api/produto/quantidade/aumentar/$idProduto'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Network error:  + $e');
      return null;
    }
  }

  Future<int?> diminuirQuantidade(int idProduto) async {
    try {
      var response = await http.put(
          Uri.parse(
              'http://localhost:8080/api/produto/quantidade/diminuir/$idProduto'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Network error:  + $e');
      return null;
    }
  }
}
