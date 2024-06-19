import 'dart:convert';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/usuarios_services/editar_usuarios.service.dart';

class EditarUsuario extends StatefulWidget {
  final Map<String, dynamic> usuario;
  const EditarUsuario({super.key, required this.usuario});

  @override
  _EditarUsuario createState() => _EditarUsuario();
}

class _EditarUsuario extends State<EditarUsuario> {
  late TextEditingController idUsuarioController;
  late TextEditingController nomeUsuarioController;
  late TextEditingController emailUsuarioController;
  late TextEditingController senhaController;

  EditarUsuarioService service = EditarUsuarioService();

  @override
  void initState() {
    super.initState();
    idUsuarioController =
        TextEditingController(text: widget.usuario['id_usuario'].toString());
    nomeUsuarioController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.usuario['nome_usuario'])));
    emailUsuarioController = TextEditingController(
        text: utf8.decode(utf8.encode(widget.usuario['email_usuario'])));

    senhaController =
        TextEditingController(text: widget.usuario['senha_usuario'].toString());
  }

  @override
  void dispose() {
    idUsuarioController.dispose();
    nomeUsuarioController.dispose();
    emailUsuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void limpaCampos() {
    nomeUsuarioController.clear();
    emailUsuarioController.clear();
    senhaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edição de Usuário'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
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
                      controller: idUsuarioController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'ID do Usuário',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.vpn_key),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: nomeUsuarioController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Usuário',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: emailUsuarioController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail do Usuário',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: senhaController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.060,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool? isValid = await service.editarUsuario(
                            int.parse(idUsuarioController.text),
                            nomeUsuarioController.text,
                            emailUsuarioController.text,
                            senhaController.text);

                        if (isValid) {
                          ElegantNotification.success(
                            title: const Text("Edição de Usuário"),
                            description:
                                const Text("O usuário foi editado com sucesso"),
                          ).show(context);
                        } else {
                          ElegantNotification.error(
                            title: const Text("Edição de Usuário"),
                            description: const Text(
                                "Ocorreu algum erro ao salvar a edição do usuário"),
                          ).show(context);
                        }
                      },
                      child: const Text('Editar Usuário'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
