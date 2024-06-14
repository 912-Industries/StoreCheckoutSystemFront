import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_checkout_system/screens/home/usuario_screens/listagem_usuario.dart';

class EditarUsuarioService {
  Future<bool> editarUsuario(
      int idUsuario,
      String nomeUsuario,
      String emailUsuario,
      String nivelPermissaoUsuario,
      String senhaUsuario) async {
    try {
      var response = await http.put(
          Uri.parse('http://localhost:8080/api/usuario/editar/$idUsuario'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nome_usuario': nomeUsuario,
            'email_usuario': emailUsuario,
            'nivel_permissao_usuario': nivelPermissaoUsuario,
            'senha_usuario': senhaUsuario,
          }));
      if (response.statusCode == 200) {
        ControleUsuarioPage.shouldRefreshData.value = true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Network error: $e');
      return false;
    }
  }
}
