import 'package:flutter/material.dart';
import '/services/estoque_service.dart';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final EstoqueService produtoService = EstoqueService();
  List<Map<String, dynamic>>? produtos;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width *
                    0.4, // 80% of screen width
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Pesquisar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: produtoService.fetchProdutos(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    produtos = snapshot.data;
                    return SingleChildScrollView(
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
                                          '')), // Atualizado para 'id_produto'
                                      DataCell(Text(produto['nome_produto'] ??
                                          '')), // Atualizado para 'nome_produto'
                                      DataCell(Text(produto['preco_produto']
                                              ?.toString() ??
                                          '')), // Atualizado para 'preco_produto'
                                      DataCell(Text(produto[
                                              'categoria_produto'] ??
                                          '')), // Atualizado para 'categoria_produto' // Atualizado para 'descricao_produto'
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
