import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../services/pedido_compra/editar_produto_service.dart';
import 'estoque.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class EditarProduto extends StatefulWidget {
  late final Map<String, dynamic> produto;
  EditarProduto({required this.produto});

  @override
  _EditarProduto createState() => _EditarProduto();
}

/**
 * TODO Regularizar edição de produto com novas colunas no banco
 * Novas colunas: precoFinal_produto, quantidade_produto, precoCusto_produto
 */
class _EditarProduto extends State<EditarProduto> {
  late TextEditingController idProdutoController;
  late TextEditingController nomeProdutoController;
  late TextEditingController descricaoProdutoController;
  late TextEditingController precoProdutoController;
  late TextEditingController categoriaProdutoController;

  @override
  void initState() {
    super.initState();
    idProdutoController =
        TextEditingController(text: widget.produto['id_produto'].toString());
    nomeProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['nome_produto'])));
    descricaoProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['descricao_produto'])));
    precoProdutoController =
        TextEditingController(text: widget.produto['preco_produto'].toString());
    categoriaProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['categoria_produto'])));
  }

  @override
  void dispose() {
    idProdutoController.dispose();
    nomeProdutoController.dispose();
    descricaoProdutoController.dispose();
    precoProdutoController.dispose();
    categoriaProdutoController.dispose();
    super.dispose();
  }

  void limpaCampos() {
    nomeProdutoController.clear();
    descricaoProdutoController.clear();
    precoProdutoController.clear();
    categoriaProdutoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edição de Produto'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: idProdutoController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'ID do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.vpn_key),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: nomeProdutoController,
                      decoration: InputDecoration(
                        labelText: 'Nome do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.shopping_bag),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: precoProdutoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'pt-BR',
                          decimalDigits: 2,
                          symbol: 'R\$ ',
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Preço do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.attach_money),
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: categoriaProdutoController,
                      decoration: InputDecoration(
                        labelText: 'Categoria do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.category_rounded),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9 ]')),
                      ],
                      textAlignVertical: TextAlignVertical.top,
                      controller: descricaoProdutoController,
                      maxLines: null,
                      maxLength: 255,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        labelText: 'Descrição do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.description),
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                      buildCounter: (
                        context, {
                        required int currentLength,
                        required int? maxLength,
                        required bool isFocused,
                      }) {
                        return DefaultTextStyle(
                          style: TextStyle(color: Colors.grey),
                          child: Text(
                            '$currentLength/$maxLength caracteres',
                            semanticsLabel: 'contador caracteres',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.060,
                    child: ElevatedButton(
                      onPressed: () async {
                        EditarProdutoService service = EditarProdutoService();
                        bool? isValid = await service.editarProduto(
                          nomeProdutoController.text,
                          double.parse(precoProdutoController.text
                              .replaceAll('R\$', '')
                              .replaceAll(',', '.')),
                          categoriaProdutoController.text,
                          descricaoProdutoController.text,
                          idProdutoController.text,
                        );

                        if (isValid != null && isValid) {
                          EstoquePage.shouldRefreshData.value =
                              !EstoquePage.shouldRefreshData.value;
                        }
                        setState(() {
                          limpaCampos();
                        });
                      },
                      child: Text('Editar Produto'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
