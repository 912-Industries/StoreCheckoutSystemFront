import 'package:flutter/material.dart';
import '/services/estoque_service.dart';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final EstoqueService produtoService = EstoqueService();
  List<Map<String, dynamic>>? produtos;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(100),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: produtoService.fetchProdutos(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              produtos = snapshot.data;
              return DataTable(
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
                rows: produtos!
                    .map((produto) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produto['id_produto']?.toString() ??
                                '')), // Atualizado para 'id_produto'
                            DataCell(Text(produto['nome_produto'] ??
                                '')), // Atualizado para 'nome_produto'
                            DataCell(Text(
                                produto['preco_produto']?.toString() ??
                                    '')), // Atualizado para 'preco_produto'
                            DataCell(Text(produto['categoria_produto'] ??
                                '')), // Atualizado para 'categoria_produto' // Atualizado para 'descricao_produto'
                          ],
                        ))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
