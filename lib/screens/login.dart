import 'package:flutter/material.dart';
import 'package:store_checkout_system/services/login_services/validate_service.dart';
import 'home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  ValidateService validateService = ValidateService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'Usuário'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erro de Login'),
                            content: const Text(
                                'O usuario ou a senha está incorreto'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Entrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
