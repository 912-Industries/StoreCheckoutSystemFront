import 'package:flutter/material.dart';
import '/services/estoque_service.dart';
import '/services/autocomplete_service.dart';
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
            .where((produto) =>
                produto['nome_produto']
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                produto['id_produto']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                produto['categoria_produto']
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
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
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
                        .where((produto) =>
                            produto['nome_produto']
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            produto['id_produto']
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            produto['categoria_produto']
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
                                    Text(produto['categoria_produto'] ?? '')),
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
