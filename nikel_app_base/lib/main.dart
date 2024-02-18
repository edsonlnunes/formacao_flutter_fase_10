import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/views/login/login.page.dart';
import 'injection_container.dart' as injection_container;
import 'shared/views/theme.store.dart';
import 'themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injection_container.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeStore = GetIt.I<ThemeStore>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        title: 'Nikel',
        debugShowCheckedModeBanner: false,
        themeMode: themeStore.themeMode,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: const LoginPage(),
      );
    });
  }
}
