import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/pedido_compra/autocomplete_service.dart';

class AutocompleteWidget extends StatefulWidget {
  final AutocompleteService autocompleteService;
  final ValueNotifier<String> query;
  final AutocompleteFieldViewBuilder fieldViewBuilder;

  AutocompleteWidget({
    required this.autocompleteService,
    required this.query,
    required this.fieldViewBuilder,
  });

  @override
  _AutocompleteWidgetState createState() => _AutocompleteWidgetState();
}

class _AutocompleteWidgetState extends State<AutocompleteWidget> {
  final TextEditingController _typeAheadController = TextEditingController();
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _typeAheadController.text = widget.query.value;
    _typeAheadController.addListener(_updateSuggestions);
  }

  void _updateSuggestions() async {
    widget.query.value = _typeAheadController.text;
    final suggestions = await widget.autocompleteService
        .getSuggestions(_typeAheadController.text);
    setState(() {
      _suggestions = suggestions
          .map((suggestion) => '${suggestion[1]}: ${suggestion[0]}')
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _suggestions
            .where((option) => option.contains(textEditingValue.text));
      },
      onSelected: (String selection) {
        widget.query.value = selection;
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController.text = widget.query.value;
        textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length));
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: "Pesquisar Produto",
          ),
        );
      },
    );
  }
}
