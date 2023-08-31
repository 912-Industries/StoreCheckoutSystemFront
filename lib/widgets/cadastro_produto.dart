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
    var categoriaProdutoController;
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
                          padding: EdgeInsets.all(5),
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
                      maxLines: 5,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: 'Descrição do Produto',
                        prefixIcon: Padding(
                          child: Icon(Icons.description),
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
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
