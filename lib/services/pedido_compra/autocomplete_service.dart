import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
  Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/autocomplete?term=$query'));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      List<Map<String, dynamic>> suggestions = [];
      for (var item in list) {
        if (item is Map) {
          var id = item['id_produto'];
          var nome = item['nome_produto'];

          // Verifique se 'id_produto' e 'nome_produto' são strings que representam índices numéricos
          if (id is String && nome is String) {
            var idIndex = int.parse(id);
            var nomeIndex = int.parse(nome);

            // Ajuste o código de acordo com a estrutura dos seus dados
            suggestions.add({'id': item[idIndex], 'nome': item[nomeIndex]});
          } else {
            suggestions
                .add({'id': item['id_produto'], 'nome': item['nome_produto']});
          }
        }
      }
      return suggestions;
    } else {
      throw Exception('Falha ao carregar sugestões');
    }
  }
}
