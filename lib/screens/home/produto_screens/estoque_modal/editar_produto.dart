import 'dart:convert';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_checkout_system/services/produto_services/cadastro_produto_service.dart';
import 'package:store_checkout_system/services/produto_services/editar_produto_service.dart';
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:store_checkout_system/helpers/quantidade_helper.dart';

class EditarProduto extends StatefulWidget {
  final Map<String, dynamic> produto;
  const EditarProduto({super.key, required this.produto});

  @override
  _EditarProduto createState() => _EditarProduto();
}

class _EditarProduto extends State<EditarProduto> {
  late TextEditingController idProdutoController;
  late TextEditingController nomeProdutoController;
  late TextEditingController descricaoProdutoController;
  late TextEditingController precoProdutoFinalController;
  late TextEditingController precoProdutoCustoController;
  late TextEditingController categoriaProdutoController;
  late TextEditingController quantidadeProdutoController;

  CadastroProdutoService service = CadastroProdutoService();

  int quantidade = 1;

  void aumentarQuantidade() {
    setState(() {
      quantidade = QuantidadeHelper.aumentarQuantidade(
          quantidade, quantidadeProdutoController);
    });
  }

  void diminuirQuantidade() {
    setState(() {
      quantidade = QuantidadeHelper.diminuirQuantidade(
          quantidade, quantidadeProdutoController);
    });
  }

  @override
  void initState() {
    super.initState();
    idProdutoController =
        TextEditingController(text: widget.produto['id_produto'].toString());
    nomeProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['nome_produto'])));
    descricaoProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['descricao_produto'])));
    precoProdutoFinalController = TextEditingController(
        text: widget.produto['precoFinal_produto'].toString());
    precoProdutoCustoController = TextEditingController(
        text: widget.produto['precoCusto_produto'].toString());
    categoriaProdutoController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.produto['categoria_produto'])));
    quantidadeProdutoController = TextEditingController(
        text: widget.produto['quantidade_produto'].toString());
  }

  @override
  void dispose() {
    idProdutoController.dispose();
    nomeProdutoController.dispose();
    descricaoProdutoController.dispose();
    precoProdutoFinalController.dispose();
    categoriaProdutoController.dispose();
    quantidadeProdutoController.dispose();
    super.dispose();
  }

  void limpaCampos() {
    nomeProdutoController.clear();
    descricaoProdutoController.clear();
    precoProdutoFinalController.clear();
    categoriaProdutoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edição de Produto'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: idProdutoController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'ID do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.vpn_key),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: nomeProdutoController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.shopping_bag),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: precoProdutoCustoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'pt-BR',
                          decimalDigits: 2,
                          symbol: 'R\$ ',
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Preço de Custo do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      enabled: false,
                      controller: precoProdutoFinalController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'pt-BR',
                          decimalDigits: 2,
                          symbol: 'R\$ ',
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Preço Final do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: categoriaProdutoController,
                      decoration: const InputDecoration(
                        labelText: 'Categoria do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.category_rounded),
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
                      decoration: const InputDecoration(
                        labelText: 'Descrição do Produto',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.description),
                        ),
                      ),
                      buildCounter: (
                        context, {
                        required int currentLength,
                        required int? maxLength,
                        required bool isFocused,
                      }) {
                        return DefaultTextStyle(
                          style: const TextStyle(color: Colors.grey),
                          child: Text(
                            '$currentLength/$maxLength caracteres',
                            semanticsLabel: 'contador caracteres',
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Quantidade: '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: diminuirQuantidade,
                        icon: const Icon(
                          Icons.remove_circle_outlined,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        child: TextFormField(
                          controller: quantidadeProdutoController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Colors.green,
                        ),
                        onPressed: aumentarQuantidade,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.060,
                    child: ElevatedButton(
                      onPressed: () async {
                        EditarProdutoService service = EditarProdutoService();
                        bool? isValid = await service.editarProduto(
                            nomeProdutoController.text,
                            double.parse(precoProdutoCustoController.text
                                .replaceAll('R\$', '')
                                .replaceAll(',', '.')),
                            double.parse(precoProdutoFinalController.text
                                .replaceAll('R\$', '')
                                .replaceAll(',', '.')),
                            categoriaProdutoController.text,
                            descricaoProdutoController.text,
                            int.parse(idProdutoController.text),
                            int.parse(quantidadeProdutoController.text));

                        if (isValid != null && isValid) {
                          EstoquePage.shouldRefreshData.value =
                              !EstoquePage.shouldRefreshData.value;
                          ElegantNotification.success(
                            title: const Text("Edição de Produto"),
                            description:
                                const Text("O produto foi editado com sucesso"),
                          ).show(context);
                        } else {
                          ElegantNotification.error(
                                  title: const Text("Edição de Produto"),
                                  description: const Text(
                                      "Ocorreu algum erro ao salvar a edição do produto"))
                              .show(context);
                        }
                      },
                      child: const Text('Editar Produto'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
