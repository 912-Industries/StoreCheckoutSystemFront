import 'package:shared_preferences/shared_preferences.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/config_services/markup_config_service.dart';

class MarkupPage extends StatefulWidget {
  const MarkupPage({super.key});

  @override
  _MarkupPage createState() => _MarkupPage();
}

class _MarkupPage extends State<MarkupPage> {
  final depesaFixaController = TextEditingController();
  final depesaVariavelController = TextEditingController();
  final margemLucroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    depesaFixaController.text = prefs.getString('despesaFixa') ?? '';
    depesaVariavelController.text = prefs.getString('despesaVariavel') ?? '';
    margemLucroController.text = prefs.getString('margemLucro') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Configuração de Markup"),
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
                      controller: depesaVariavelController,
                      decoration: const InputDecoration(
                        labelText: 'Despesa Variavel',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.paid_rounded),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: depesaFixaController,
                      decoration: const InputDecoration(
                        labelText: 'Despesa Fixa',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.account_balance_wallet_rounded),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: margemLucroController,
                        decoration: const InputDecoration(
                          labelText: 'Margem de Lucro',
                          suffixText: "%",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.request_quote_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.060,
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();

                        MarkupConfigService service = MarkupConfigService();
                        int despesaFixa = int.parse(depesaFixaController.text);
                        int despesaVariavel =
                            int.parse(depesaVariavelController.text);
                        int margemLucro = int.parse(margemLucroController.text);
                        double ResultadoMarkup = ((100) /
                            ((100) -
                                (despesaFixa + despesaVariavel + margemLucro)));
                        try {
                          ResultadoMarkup =
                              double.parse(ResultadoMarkup.toStringAsFixed(2));
                        } catch (e) {
                          print(
                              'Não foi possível converter a string para um double: $e');
                          return;
                        }
                        prefs.setString(
                            'despesaFixa', depesaFixaController.text);
                        prefs.setString(
                            'despesaVariavel', depesaVariavelController.text);
                        prefs.setString(
                            'margemLucro', margemLucroController.text);
                        prefs.setString(
                            'resultadoMarkup', ResultadoMarkup.toString());

                        bool? isValid = await service.cadastroMarkup(
                          despesaFixa,
                          despesaVariavel,
                          margemLucro,
                          ResultadoMarkup,
                        );
                        if (isValid != null && isValid) {
                          ElegantNotification.success(
                            title: const Text("Configuração de Markup"),
                            description: const Text(
                                "A configuração de markup foi salva com sucesso"),
                          ).show(context);
                        } else {
                          ElegantNotification.error(
                            title: const Text("Configuração de Markup"),
                            description: const Text(
                                "Ocorreu algum erro ao salvar a configuração de markup"),
                          ).show(context);
                        }
                      },
                      child: const Text("Salvar Configuração do Markup"),
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
