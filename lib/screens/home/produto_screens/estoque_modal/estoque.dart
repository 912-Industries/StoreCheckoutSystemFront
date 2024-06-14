import 'dart:async';

import 'package:flutter/material.dart';
import 'package:store_checkout_system/screens/home/produto_screens/cadastro_produto/cadastro_produto.dart';
import 'package:store_checkout_system/screens/home/produto_screens/pedido_compra/pedido_compra.dart';
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/editar_produto.dart';
import 'package:store_checkout_system/services/produto_services/estoque_service.dart';
import 'package:store_checkout_system/services/produto_services/excluir_produto_service.dart';
import 'package:store_checkout_system/widgets/estoque_widgets/icone_exclusao.dart';

class EstoquePage extends StatefulWidget {
  static ValueNotifier<bool> shouldRefreshData = ValueNotifier(false);

  const EstoquePage({super.key});

  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final EstoqueService produtoService = EstoqueService();
  final ExcluirProdutoService excluirProdutoService = ExcluirProdutoService();
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
        produtos = newProdutos;
      });
    }
  }

  Future<bool> excluirProduto(int idProduto) async {
    bool isDeleted =
        await excluirProdutoService.excluirProduto(idProduto.toString());
    if (isDeleted) {
      fetchData();
      setState(() {
        produtos?.removeWhere((produto) => produto['id_produto'] == idProduto);
      });
    }
    return isDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _typeAheadController,
                      decoration: const InputDecoration(
                        hintText: "Pesquisar Produto",
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CadastroProdutoPage(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.add_circle_outline_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DataTable(
                      showCheckboxColumn: false,
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
                            'Preço Final',
                          ),
                        ),
                        DataColumn(
                          label: Text('Quantidade'),
                        ),
                        DataColumn(label: Text('Ações')),
                      ],
                      rows: List<DataRow>.from(
                        produtos!
                            .where((produto) => produto['nome_produto']
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .map((produto) => DataRow(
                                  onSelectChanged: (bool? selected) {
                                    if (selected == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              EditarProduto(produto: produto)),
                                        ),
                                      );
                                    }
                                  },
                                  cells: <DataCell>[
                                    DataCell(Text(
                                      produto['id_produto']?.toString() ?? '',
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(
                                        Text(produto['nome_produto'] ?? '')),
                                    DataCell(Text(produto['precoFinal_produto']
                                            .toString() ??
                                        '')),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                produto['quantidade_produto']
                                                        .toString() ??
                                                    '',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(Row(
                                      children: [
                                        IconeExclusao(
                                            idProduto: produto['id_produto']
                                                .toString(),
                                            excluirProduto: excluirProduto),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_rounded,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PedidoCompraPage(
                                                        produto: produto),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ))
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
