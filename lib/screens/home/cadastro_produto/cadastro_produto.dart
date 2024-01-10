import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_checkout_system/services/produto/cadastro_produto_service.dart';
import 'package:store_checkout_system/screens/home/estoque_modal/estoque.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:store_checkout_system/helpers/quantidade_helper.dart';

class CadastroProdutoPage extends StatefulWidget {
  @override
  _CadastroProduto createState() => _CadastroProduto();
}

class _CadastroProduto extends State<CadastroProdutoPage> {
  final nomeProdutoController = TextEditingController();
  final descricaoProdutoController = TextEditingController();
  final precoProdutoController = TextEditingController();
  final categoriaProdutoController = TextEditingController();
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
    categoriaProdutoController.clear();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                      labelText: 'Preço de Custo',
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
                  height: 20,
                ),
                Text('Quantidade: '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: diminuirQuantidade,
                      icon: Icon(
                        Icons.remove_circle_outlined,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      width: 50.0, // ajuste este valor conforme necessário
                      child: TextFormField(
                        controller: quantidadeProdutoController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.green,
                      ),
                      onPressed: aumentarQuantidade,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.060,
                  child: ElevatedButton(
                    onPressed: () async {
                      CadastroProdutoService service = CadastroProdutoService();

                      String precoProdutoText = precoProdutoController.text;
                      precoProdutoText = precoProdutoText.replaceAll('R\$', '');
                      precoProdutoText = precoProdutoText.replaceAll(',', '.');

                      double precoProduto;
                      int quantidade =
                          int.parse(quantidadeProdutoController.text);
                      try {
                        precoProduto = double.parse(precoProdutoText);
                      } catch (e) {
                        print(
                            'Não foi possível converter a string para um double: $e');
                        return;
                      }

                      bool? isValid = await service.cadastroProduto(
                          nomeProdutoController.text,
                          precoProduto,
                          categoriaProdutoController.text,
                          descricaoProdutoController.text,
                          quantidade);

                      setState(() {
                        limpaCampos();
                      });

                      if (isValid != null && isValid) {
                        EstoquePage.shouldRefreshData.value =
                            !EstoquePage.shouldRefreshData.value;
                        ElegantNotification.success(
                          title: Text("Pedido de Compra de Produto"),
                          description: Text(
                              "O pedido de compra foi contabilizado com sucesso"),
                        ).show(context);
                      } else {
                        ElegantNotification.error(
                          title: Text("Pedido de Compra de Produto"),
                          description: Text(
                              "Ocorreu algum erro ao contabilizar o pedido de compra"),
                        ).show(context);
                      }
                    },
                    child: Text('Pedido de Compra de Produto'),
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
