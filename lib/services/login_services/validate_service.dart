import 'dart:convert';

import 'package:http/http.dart' as http;

class ValidateService {
  Future<bool> validateData(String username, String password) async {
    try {
      var response = await http.post(
          Uri.parse('http://localhost:8080/api/usuario/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {'nome_usuario': username, 'senha_usuario': password}));

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
