import 'package:flutter/material.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/cadastro_usuario.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/editar_usuario.dart';

class ControleUsuarioPage extends StatefulWidget {
  @override
  _ControleUsuario createState() => _ControleUsuario();
}

//TODO Após finalizar o autocomplete de produtos implementar controle de usuario
class _ControleUsuario extends State<ControleUsuarioPage> {
  List<Map<String, dynamic>>? usuarios = [];
  String query = '';
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _typeAheadController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar Usuário',
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadastroUsuarioPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.8),
                          child: Icon(Icons.person_add_alt_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    DataTable(
                      showCheckboxColumn: false,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Id',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nome',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nivel Permissão',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Ações',
                          ),
                        ),
                      ],
                      rows: List<DataRow>.from(
                        usuarios!
                            .where((usuario) => usuario['nome_usuario']
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .map(
                              (usuario) => DataRow(
                                  onSelectChanged: (bool? selected) {
                                    if (selected == true) {
                                      Navigator.push(
                                        context,
                                        //TODO Finalizar arquivo edição de usuario
                                        MaterialPageRoute(
                                            builder: (context) => EditarUsuario(
                                                usuario: usuario)),
                                      );
                                    }
                                  },
                                  cells: <DataCell>[
                                    DataCell(Text(
                                      usuario['id_usuario']?.toString() ?? '',
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(Text(
                                      usuario['nome_usuario'] ?? '',
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(Text(
                                      usuario['email_usuario'] ?? '',
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(Text(
                                      usuario['nivel_permissao_usuario']
                                              ?.toString() ??
                                          '',
                                      textAlign: TextAlign.center,
                                    )),
                                  ]),
                              //TODO Fazer DataCell com Icones para operação no banco
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
