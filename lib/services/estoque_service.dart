import 'dart:convert';
import 'package:http/http.dart' as http;

class EstoqueService {
  Future<List<Map<String, dynamic>>> fetchProdutos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/produto'));

    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }
}
