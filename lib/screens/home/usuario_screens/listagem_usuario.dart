import 'package:flutter/material.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/cadastro_usuario.dart';
import 'package:store_checkout_system/screens/home/usuario_screens/editar_usuario.dart';
import 'package:store_checkout_system/services/usuarios_services/controle_usuarios_services.dart';
import 'package:store_checkout_system/services/usuarios_services/excluir_usuarios_service.dart';
import 'package:store_checkout_system/widgets/estoque_widgets/icone_exclusao.dart';

class ControleUsuarioPage extends StatefulWidget {
  static ValueNotifier<bool> shouldRefreshData = ValueNotifier(false);

  const ControleUsuarioPage({super.key});

  @override
  _ControleUsuario createState() => _ControleUsuario();
}

class _ControleUsuario extends State<ControleUsuarioPage> {
  List<Map<String, dynamic>>? usuarios = [];
  String query = '';
  final TextEditingController _typeAheadController = TextEditingController();
  final ControleUsuarioService _controleUsuarioService =
      ControleUsuarioService();
  final ExcluirUsuarioService excluirUsuarioService = ExcluirUsuarioService();

  @override
  void initState() {
    _loadUsuarios();
    ControleUsuarioPage.shouldRefreshData.addListener((fetchData));
    super.initState();
  }

  Future<void> _loadUsuarios() async {
    final usuariosFetched = await _controleUsuarioService.fetchUsuarios();
    setState(() {
      usuarios = usuariosFetched;
    });
  }

  void fetchData() async {
    var newUsuarios = await _controleUsuarioService.fetchUsuarios();
    if (newUsuarios.isNotEmpty) {
      setState(() {
        usuarios = newUsuarios;
      });
    }
  }

  Future<bool> excluirUsuario(int idProduto) async {
    bool isDeleted =
        await excluirUsuarioService.excluirUsuario(idProduto.toString());
    if (isDeleted) {
      fetchData();
      setState(() {
        usuarios?.removeWhere((usuario) => usuario['id_usuario'] == idProduto);
      });
    }
    return isDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _typeAheadController,
                      decoration: const InputDecoration(
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
                              builder: (context) => const CadastroUsuarioPage(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 0.8),
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
                    usuarios != null
                        ? DataTable(
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditarUsuario(
                                                          usuario: usuario)),
                                            );
                                          }
                                        },
                                        cells: <DataCell>[
                                          DataCell(Text(
                                            usuario['id_usuario'].toString() ??
                                                '',
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
                                          DataCell(Row(
                                            children: [
                                              IconeExclusao(
                                                  idProduto:
                                                      usuario['id_usuario']
                                                          .toString(),
                                                  excluirProduto:
                                                      excluirUsuario),
                                            ],
                                          ))
                                        ]),
                                  ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
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
