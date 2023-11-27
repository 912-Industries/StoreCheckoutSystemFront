import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/pedido_compra/autocomplete_service.dart';

class AutocompleteWidget extends StatefulWidget {
  final AutocompleteService autocompleteService;
  final ValueNotifier<String> query;
  final AutocompleteFieldViewBuilder fieldViewBuilder;

  AutocompleteWidget(
      {required this.autocompleteService,
      required this.query,
      required this.fieldViewBuilder});

  @override
  _AutocompleteWidgetState createState() => _AutocompleteWidgetState();
}

class _AutocompleteWidgetState extends State<AutocompleteWidget> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeAheadController.text = widget.query.value;
    _typeAheadController.addListener(() {
      widget.query.value = _typeAheadController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map<String, dynamic>>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Map<String, dynamic>>.empty();
        }
        return widget.autocompleteService.getSuggestions(textEditingValue.text);
      },
      onSelected: (Map<String, dynamic> selection) {
        widget.query.value = selection['nome'];
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
        );
      },
      optionsViewBuilder: (context, onSelected, options) => LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
                height: 52.0 * options.length,
                width: constraints.biggest.width,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> option =
                          options.elementAt(index);
                      return ListTile(
                        title: Text('${option['id']} - ${option['nome']}'),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    })),
          ),
        ),
      ),
    );
  }
}
