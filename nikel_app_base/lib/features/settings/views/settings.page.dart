import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../shared/views/theme.store.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/app.constants.dart';
import '../../authentication/views/login/login.page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final store = GetIt.I.get<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: Column(
        children: [
          OptionSetting(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aparência'),
                Observer(
                  builder: (_) {
                    return SizedBox(
                      width: 150,
                      child: DropdownButton(
                        onChanged: (value) => store.changeThemeMode(value!),
                        value: store.themeMode,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Dia'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Noite'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('Sistema'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          OptionSetting(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Sair'),
                Icon(Icons.logout),
              ],
            ),
            onPressed: () {
              AppConstants.token = null;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (c) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OptionSetting extends StatelessWidget {
  final Widget content;
  final Function? onPressed;
  const OptionSetting({super.key, required this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed != null ? () => onPressed!() : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: content,
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
