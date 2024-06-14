import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/listagem_usuario.dart';
import 'package:store_checkout_system/services/usuarios_services/cadastro_usuarios_service.dart';

class CadastroUsuarioPage extends StatefulWidget {
  final Function() onUserCreated;
  const CadastroUsuarioPage({required this.onUserCreated, super.key});

  @override
  _CadastroUsuario createState() => _CadastroUsuario();
}

class _CadastroUsuario extends State<CadastroUsuarioPage> {
  final nomeUsuarioController = TextEditingController();
  final nomeCompletoUsuarioController = TextEditingController();
  final senhaUsuarioController = TextEditingController();
  final confirmarSenhaUsuarioController = TextEditingController();
  final emailUsuarioController = TextEditingController();

  void verificaSenha() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void limpaCampos() {
    nomeUsuarioController.clear();
    nomeCompletoUsuarioController.clear();
    senhaUsuarioController.clear();
    confirmarSenhaUsuarioController.clear();
    emailUsuarioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário"),
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
                    controller: nomeUsuarioController,
                    decoration: const InputDecoration(
                      labelText: "Nome de Usuário",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.person_2_rounded),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: nomeCompletoUsuarioController,
                    decoration: const InputDecoration(
                      labelText: "Nome Completo",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.abc_rounded),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: emailUsuarioController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.email_rounded),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: senhaUsuarioController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.password_rounded),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: confirmarSenhaUsuarioController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirmar Senha",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.domain_verification_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.060,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        CadastroUsuarioService service =
                            CadastroUsuarioService();

                        bool? isValid = await service.cadastroUsuario(
                            nomeUsuarioController.text,
                            emailUsuarioController.text,
                            senhaUsuarioController.text,
                            nomeCompletoUsuarioController.text);
                        if (isValid != null && isValid) {
                          widget.onUserCreated;
                        }
                      } catch (e) {
                        ElegantNotification.error(
                          title: const Text("Pedido de Compra de Produto"),
                          description: Text(
                              "Ocorreu algum erro ao contabilizar o pedido de compra: $e"),
                        ).show(context);
                      } finally {
                        ElegantNotification.success(
                          title: const Text("Pedido de Compra de Produto"),
                          description: const Text(
                              "O pedido de compra foi contabilizado com sucesso"),
                        ).show(context);
                        limpaCampos();
                      }
                    },
                    child: const Text('Cadastrar Usuário'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
