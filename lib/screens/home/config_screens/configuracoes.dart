import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:store_checkout_system/screens/home/config_screens/markup_config.dart';
import 'package:store_checkout_system/screens/home/config_screens/cadastro_categoria_config.dart';

class ConfiguracaoPage extends StatelessWidget {
  const ConfiguracaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Configuração PDV'),
          tiles: <SettingsTile>[
            SettingsTile(
              title: const Text('Configuração de Markup'),
              leading: const Icon(Icons.shopping_bag_rounded),
              onPressed: (BuildContext context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MarkupPage()),
                );
              },
            ),
            SettingsTile(
              title: const Text('Cadastro Categoria'),
              leading: const Icon(Icons.category_rounded),
              onPressed: (BuildContext context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CadastroCategoria()));
              },
            ),
          ],
        ),
      ],
    ));
  }
}
