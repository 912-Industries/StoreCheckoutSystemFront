import 'dart:convert';
import 'package:http/http.dart' as http;

class EditarProdutoService {
  Future<bool>? editarProduto(String NomeProduto, double PrecoProduto,
    String CategoriaProduto, String DescricaoProduto, String idProduto) async {
  try {
    var response =
        await http.put(Uri.parse('http://192.168.10.2:8080/api/produto/editar/$idProduto'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nome_produto': NomeProduto,
              'preco_produto': PrecoProduto,
              'categoria_produto': CategoriaProduto,
              'descricao_produto': DescricaoProduto
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
}