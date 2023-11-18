import 'package:flutter/material.dart';

class ControleUsuarioPage extends StatefulWidget {
  @override
  _ControleUsuario createState() => _ControleUsuario();
}

//TODO Após finalizar o autocomplete de produtos implementar controle de usuario
class _ControleUsuario extends State<ControleUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [Container()],
          ),
        ),
      ),
    );
  }
}
