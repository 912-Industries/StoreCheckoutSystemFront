import 'package:http/http.dart' as http;

class ExcluirUsuarioService {
  Future<bool> excluirUsuario(String idUsuario) async {
    try {
      var response = await http.delete(
          Uri.parse('http://localhost:8080/api/usuario/excluir/$idUsuario'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 204) {
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
