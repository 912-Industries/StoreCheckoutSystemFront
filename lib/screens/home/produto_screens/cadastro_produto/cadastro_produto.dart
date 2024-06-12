import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_checkout_system/services/produto_services/cadastro_produto_service.dart';
import 'package:store_checkout_system/screens/home/produto_screens/estoque_modal/estoque.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:store_checkout_system/helpers/quantidade_helper.dart';

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  _CadastroProduto createState() => _CadastroProduto();
}

class _CadastroProduto extends State<CadastroProdutoPage> {
  final nomeProdutoController = TextEditingController();
  final descricaoProdutoController = TextEditingController();
  final precoProdutoController = TextEditingController();
  var quantidadeProdutoController = TextEditingController();

  int quantidade = 1;

  @override
  void initState() {
    super.initState();
    quantidadeProdutoController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    quantidadeProdutoController.dispose();
    super.dispose();
  }

  void limpaCampos() {
    nomeProdutoController.clear();
    descricaoProdutoController.clear();
    precoProdutoController.clear();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Produto"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    controller: precoProdutoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter(
                        locale: 'pt-BR',
                        decimalDigits: 2,
                        symbol: 'R\$ ',
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Preço de Custo',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.attach_money),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
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
                  height: 20,
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
                        onChanged: (value) {
                          setState(() {
                            quantidade = int.parse(value);
                          });
                        },
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
                      CadastroProdutoService service = CadastroProdutoService();

                      String precoProdutoText = precoProdutoController.text;
                      precoProdutoText = precoProdutoText.replaceAll('R\$', '');
                      precoProdutoText = precoProdutoText.replaceAll('.', '');
                      precoProdutoText = precoProdutoText.replaceAll(',', '');

                      int length = precoProdutoText.length;
                      precoProdutoText =
                          '${precoProdutoText.substring(0, length - 2)}.${precoProdutoText.substring(length - 2)}';
                      double precoProduto = double.parse(precoProdutoText);

                      try {
                        quantidade =
                            int.parse(quantidadeProdutoController.text);
                      } catch (e) {
                        print(
                            'Não foi possível converter a string para um double: $e');
                        return;
                      }

                      bool? isValid = await service.cadastroProduto(
                          nomeProdutoController.text,
                          precoProduto,
                          descricaoProdutoController.text,
                          quantidade);

                      setState(() {
                        limpaCampos();
                      });

                      if (isValid != null && isValid) {
                        EstoquePage.shouldRefreshData.value =
                            !EstoquePage.shouldRefreshData.value;
                        ElegantNotification.success(
                          title: const Text("Pedido de Compra de Produto"),
                          description: const Text(
                              "O pedido de compra foi contabilizado com sucesso"),
                        ).show(context);
                      } else {
                        ElegantNotification.error(
                          title: const Text("Pedido de Compra de Produto"),
                          description: const Text(
                              "Ocorreu algum erro ao contabilizar o pedido de compra"),
                        ).show(context);
                      }
                    },
                    child: const Text('Pedido de Compra de Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
