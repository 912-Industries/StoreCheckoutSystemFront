import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteService {
     FutureOr<Iterable<String>> optionsBuilder(TextEditingValue value) {

    if (value.text.isEmpty) {
      return const Iterable<String>.empty();
    }
    return getSuggestions(value.text);
  }

  void onSelected(String selection) {
    print('You just selected $selection');
  }

  Future<List<String>> getSuggestions(String query) async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/autocomplete'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}