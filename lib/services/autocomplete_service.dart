import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
  Future<List<String>> getSuggestions(String query) async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/autocomplete?term=$query'));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      List<String> suggestions = [];
      for (var item in list) {
        suggestions.add(item[0].toString()); // id
        suggestions.add(item[1].toString()); // nome
        suggestions.add(item[2].toString()); // categoria
      }
      return suggestions;
    } else {
      throw Exception('Failed to load suggestions');
    }
    return []; // Add this line to ensure your function always returns a value
  }
}
