import 'dart:convert';
import 'package:http/http.dart' as http;

class CadastroProdutoService {
  Future<bool>? cadastroProduto(String NomeProduto, double PrecoCustoProduto,
      String DescricaoProduto, int QuantidadeProduto) async {
    try {
      var response = await http.post(
          Uri.parse('http://localhost:8080/api/produto/cadastro'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nome_produto': NomeProduto,
            'precoCusto_produto': PrecoCustoProduto,
            'descricao_produto': DescricaoProduto,
            'quantidade_produto': QuantidadeProduto
          }));
      if (response.statusCode == 201) {
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
