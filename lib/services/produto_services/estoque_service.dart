import 'dart:convert';
import 'package:http/http.dart' as http;

class EstoqueService {
  Future<List<Map<String, dynamic>>> fetchProdutos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/produto'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<Map<String, dynamic>> fetchPrecoProdutoById(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/precoProduto/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar preco produto');
    }
  }

  Future<Map<String, dynamic>> fetchCategoriaById(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/categoria/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar categoria');
    }
  }
}
