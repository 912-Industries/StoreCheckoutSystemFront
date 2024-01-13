import 'package:flutter/material.dart';

class CadastroCategoria extends StatefulWidget {
  @override
  _CadastroCategoria createState() => _CadastroCategoria();
}

class _CadastroCategoria extends State<CadastroCategoria> {
  final TextEditingController categoriaProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Categoria'),
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
                    controller: categoriaProduto,
                    decoration: InputDecoration(
                      labelText: 'Nome da Categoria',
                      prefixIcon: Padding(
                        child: Icon(Icons.category_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                // TODO Ao clicar no botão cadastrar categoria na tabela correspondente
                ElevatedButton(
                  onPressed: () async {},
                  child: Text('Cadastrar Categoria'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
