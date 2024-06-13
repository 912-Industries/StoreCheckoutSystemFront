import 'package:flutter/material.dart';

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
