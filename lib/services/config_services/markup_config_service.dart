import 'package:http/http.dart' as http;
import 'dart:convert';

class MarkupConfigService {
  Future<bool>? cadastroMarkup(int DespesaFixa, int DespesaVariavel,
      int MargemLucro, double ResultadoMarkup) async {
    try {
      var response = await http.post(
          Uri.parse('http://localhost:8080/api/markup/cadastro'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'despesaFixa_markup': DespesaFixa,
            'despesaVariaveis_markup': DespesaVariavel,
            'margemLucro_markup': MargemLucro,
            'resultadoMarkup_markup': ResultadoMarkup,
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Network error: + $e');
      return false;
    }
  }
}
