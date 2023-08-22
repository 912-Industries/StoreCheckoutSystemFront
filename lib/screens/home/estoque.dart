import 'package:flutter/material.dart';
import '/services/estoque_service.dart';
import 'dart:convert';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final EstoqueService produtoService = EstoqueService();
  List<Map<String, dynamic>>? produtos = [];
  String query = '';
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
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
                child: TextField(
                  controller: this._typeAheadController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Pesquisar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                      fetchData();
                    });
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
                                DataCell(Text(produto['id_produto']
                                        ?.toString() ??
                                    '')),
                                DataCell(Text(produto['nome_produto'] ?? '')),
                                DataCell(Text(produto['preco_produto']
                                        ?.toString() ??
                                    '')),
                                DataCell(Text(
                                    produto['categoria_produto'] ?? '')),
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
