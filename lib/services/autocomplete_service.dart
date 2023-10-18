import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
  Future<List<String>> getSuggestions(String query) async {
    final response = await http
        .get(Uri.parse('http://192.168.10.2:8080/api/autocomplete?term=$query'));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      List<String> suggestions = [];
      for (var item in list) {
        suggestions.add(
            item.toString()); // Access the item directly without using an index
      }
      return suggestions;
    } else {
      throw Exception('Falha ao carregar sugestões');
    }
  }
}
