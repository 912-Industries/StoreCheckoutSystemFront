import 'package:flutter/material.dart';

class ConfiguracaoPage extends StatefulWidget {
  @override
  _ConfiguracaoPage createState() => _ConfiguracaoPage();
}

class _ConfiguracaoPage extends State<ConfiguracaoPage> {
  final depesaFixaController = TextEditingController();
  final depesaVariavelController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          child:   Icon( Icons.paid_rounded), 
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: depesaVariavelController,
                      decoration: InputDecoration(
                        labelText: 'Despesa Fixa',
                        prefixIcon: Padding(
                          child:  Icon( Icons.account_balance_wallet_rounded), 
                          padding: EdgeInsets.all(5),
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
