import 'package:flutter/material.dart';

class CadastroCategoria extends StatefulWidget {
  const CadastroCategoria({super.key});

  @override
  _CadastroCategoria createState() => _CadastroCategoria();
}

class _CadastroCategoria extends State<CadastroCategoria> {
  final TextEditingController categoriaProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Categoria'),
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
                    controller: categoriaProduto,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Categoria',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.category_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () async {},
                  child: const Text('Cadastrar Categoria'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
