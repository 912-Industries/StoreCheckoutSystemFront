import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<String>> getSuggestions(String input) async {
    final response = await http.get('YOUR_API_URL' as Uri);
    if (response.statusCode == 200) {
      final List<String> l = json.decode(response.body);
      return l;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}