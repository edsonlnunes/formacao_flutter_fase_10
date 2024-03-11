import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'features/splash_screen/views/splash_screen.page.dart';
import 'shared/utils/constants.dart';
import 'theme/theme.dart';

void initSL() {
  GetIt.I.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: Constants.apiURL)),
  );
}

void main() {
  initSL();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikel',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const SplashScreenPage(),
    );
  }
}
