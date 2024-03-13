import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/produto_services/autocomplete_service.dart';

class AutocompleteWidget extends StatelessWidget {
  final TextEditingController controller;

  const AutocompleteWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: "Pesquisar Produto",
      ),
    );
  }
}
