import 'dart:ffi';

import 'package:flutter/material.dart';

class MarkupPage extends StatefulWidget {
  @override
  _MarkupPage createState() => _MarkupPage();
}

class _MarkupPage extends State<MarkupPage> {
  final depesaFixaController = TextEditingController();
  final depesaVariavelController = TextEditingController();
  final margemLucroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Configuração de Markup"),
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
                      controller: depesaVariavelController,
                      decoration: InputDecoration(
                        labelText: 'Despesa Variavel',
                        prefixIcon: Padding(
                          child: Icon(Icons.paid_rounded),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: depesaFixaController,
                      decoration: InputDecoration(
                        labelText: 'Despesa Fixa',
                        prefixIcon: Padding(
                          child: Icon(Icons.account_balance_wallet_rounded),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 20), // Adiciona espaçamento na parte inferior
                      child: TextFormField(
                        controller: margemLucroController,
                        decoration: InputDecoration(
                          labelText: 'Margem de Lucro',
                          suffixText: "%",
                          prefixIcon: Padding(
                            child: Icon(Icons.request_quote_rounded),
                            padding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.060,
                    child: ElevatedButton(
                      onPressed: () {
                        double despesaFixa = double.parse(depesaFixaController.text);
                        double despesaVariavel = double.parse(depesaVariavelController.text);
                        double margemLucro = double.parse(margemLucroController.text);
                        double markup = ((100)/((100) - (despesaFixa+despesaVariavel+margemLucro)));
                        markup = double.parse(markup.toStringAsFixed(2));
                        print(markup);
                      },
                      child: Text("Salvar Configuração do Markup"),
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
