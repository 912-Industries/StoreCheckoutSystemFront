import 'package:flutter/material.dart';

class CadastroProduto extends StatefulWidget {
  @override
  _CadastroProduto createState() => _CadastroProduto();
}

class _CadastroProduto extends State<CadastroProduto> {
  @override
  Widget build(BuildContext context) {
    var nomeProdutoController;
    var descricaoProdutoController;
    var precoProdutoController;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Produto'),
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
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: descricaoProdutoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.description),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: precoProdutoController,
                      decoration: InputDecoration(
                        labelText: 'Preço do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.attach_money),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
