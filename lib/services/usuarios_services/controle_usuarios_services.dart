// controle_usuario_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ControleUsuarioService {
  Future<List<Map<String, dynamic>>> fetchUsuarios() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/usuario'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
