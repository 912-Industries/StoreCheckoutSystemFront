import 'package:http/http.dart' as http;

class ExcluirProdutoService {
  Future<bool> excluirProduto(String idProduto) async {
    try {
      var response = await http.delete(
          Uri.parse('http://192.168.10.2:8080/api/produto/excluir/$idProduto'),
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
