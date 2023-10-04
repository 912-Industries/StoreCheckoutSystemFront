import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/services/cadastro_produto_service.dart';
import '/screens/home/estoque.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class CadastroProduto extends StatefulWidget {
  @override
  _CadastroProduto createState() => _CadastroProduto();
}

class _CadastroProduto extends State<CadastroProduto> {
  final nomeProdutoController = TextEditingController();
  final descricaoProdutoController = TextEditingController();
  final precoProdutoController = TextEditingController();
  final categoriaProdutoController = TextEditingController();

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
          title: const Text('Cadastro de Produto'),
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
                            CadastroProdutoService service =
                                CadastroProdutoService();
                            bool? isValid = await service.cadastroProduto(
                              nomeProdutoController.text,
                              double.parse(precoProdutoController.text
                                  .replaceAll('R\$', '')
                                  .replaceAll(',', '.')),
                              categoriaProdutoController.text,
                              descricaoProdutoController.text,
                            );

                            setState(() {
                              limpaCampos();
                            });

                            if (isValid != null && isValid) {
                              EstoquePage.shouldRefreshData.value =
                                  !EstoquePage.shouldRefreshData.value;
                            }
                          },
                          child: Text('Cadastrar Produto'),
                        )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
