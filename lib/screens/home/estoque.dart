import 'dart:async';

import 'package:flutter/material.dart';
import '/services/estoque_service.dart';
import '/services/autocomplete_service.dart';
import '../../widgets/editar_produto.dart';
import '/widgets/cadastro_produto.dart';

class EstoquePage extends StatefulWidget {
  static ValueNotifier<bool> shouldRefreshData = ValueNotifier(false);

  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final EstoqueService produtoService = EstoqueService();
  final AutocompleteService autocompleteService = AutocompleteService();
  final CadastroProduto cadastroProduto = CadastroProduto();
  List<Map<String, dynamic>>? produtos = [];
  String query = '';
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    EstoquePage.shouldRefreshData.addListener(fetchData);
    fetchData();
    Timer? debounce;
    _typeAheadController.addListener(() {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () {
        setState(() {
          query = _typeAheadController.text;
          fetchData();
        });
      });
    });
  }

  @override
  void dispose() {
    EstoquePage.shouldRefreshData.removeListener(fetchData);
    super.dispose();
  }

  void fetchData() async {
    var newProdutos = await produtoService.fetchProdutos();
    if (newProdutos.isNotEmpty) {
      setState(() {
        produtos = newProdutos
            .where((produto) => produto['nome_produto']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return autocompleteService
                        .getSuggestions(textEditingValue.text);
                  },
                  onSelected: (String selection) {
                    setState(() {
                      query = selection;
                      fetchData();
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    textEditingController.text = query;
                    textEditingController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: textEditingController.text.length));
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add_circle_rounded),
                          onPressed: () async {
                            bool? isNewProductAdded =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CadastroProduto()),
                            );
                            if (isNewProductAdded != null &&
                                isNewProductAdded) {
                              fetchData();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Id',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Nome',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Preço',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Categoria',
                      ),
                    ),
                  ],
                  rows: List<DataRow>.from(
                    produtos!
                        .where((produto) => produto['nome_produto']
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .map((produto) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(
                                    produto['id_produto']?.toString() ?? '')),
                                DataCell(Text(produto['nome_produto'] ?? '')),
                                DataCell(Text(
                                    produto['preco_produto']?.toString() ??
                                        '')),
                                DataCell(
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(produto['categoria_produto'] ?? ''),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.edit_rounded),
                                            onPressed: () {
                                              print(
                                                  'ID: ${produto['id_produto']}, Nome: ${produto['nome_produto']}, Preco: ${produto['preco_produto']}, Categoria: ${produto['categoria_produto']}');

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      EditarProduto()),
                                                ),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_rounded),
                                            onPressed: () {},
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
