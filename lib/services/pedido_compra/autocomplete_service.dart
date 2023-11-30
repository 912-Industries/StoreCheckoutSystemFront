import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
  Future<List<String>> getSuggestions(String query) async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/api/autocomplete?term=$query'));

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body) as List;
      return list.map((item) => item[1] as String).toList(); // change here
    } else {
      throw Exception('Falha ao carregar sugestões');
    }
  }
}
