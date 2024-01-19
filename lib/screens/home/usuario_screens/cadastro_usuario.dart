import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/usuarios_services/cadastro_usuarios_service.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/listagem_usuario.dart';

import 'package:elegant_notification/elegant_notification.dart';

class CadastroUsuarioPage extends StatefulWidget {
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
        title: Text("Cadastro de Usuário"),
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
                    controller: nomeUsuarioController,
                    decoration: InputDecoration(
                      labelText: "Nome de Usuário",
                      prefixIcon: Padding(
                        child: Icon(Icons.person_2_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: nomeCompletoUsuarioController,
                    decoration: InputDecoration(
                      labelText: "Nome Completo",
                      prefixIcon: Padding(
                        child: Icon(Icons.abc_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: emailUsuarioController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Padding(
                        child: Icon(Icons.email_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: senhaUsuarioController,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      prefixIcon: Padding(
                        child: Icon(Icons.password_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: confirmarSenhaUsuarioController,
                    decoration: InputDecoration(
                      labelText: "Confirmar Senha",
                      prefixIcon: Padding(
                        child: Icon(Icons.domain_verification_rounded),
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.060,
                  child: ElevatedButton(
                    onPressed: () async {
                      CadastroUsuarioService service = CadastroUsuarioService();

                      bool? isValid = await service.cadastroUsuario(
                          nomeUsuarioController.text,
                          emailUsuarioController.text,
                          senhaUsuarioController.text,
                          nomeCompletoUsuarioController.text);

                      setState(() {
                        limpaCampos();
                      });
                    },
                    child: Text('Cadastrar Usuário'),
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
