import 'package:flutter/material.dart';
import '/services/validate_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  ValidateService validateService = ValidateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 400,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Usuário'),
              ),
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ),
            SizedBox(
              width: 150,
              height: 65,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool isValid = await validateService.validateData(
                        _userNameController.text, _passwordController.text);
                    if (isValid) {
                      print('deu certo');
                    } else {
                      print('deu errado');
                    }
                  },
                  child: Text('Entrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
