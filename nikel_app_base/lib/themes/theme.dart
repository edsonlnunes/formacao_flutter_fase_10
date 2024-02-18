import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData darkTheme() {
  const Color primaryColor = Color(0xFF4C79D3);
  const Color secondaryColor = Color(0xFF4E0070);
  const Color bgColor = Color(0xFF313336);
  const Color lineColor = Colors.white;

  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: bgColor,
    primarySwatch: getMaterialColor(primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          primaryColor,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondaryColor, width: 5),
        ),
      ),
    ),
    dividerColor: lineColor,
    extensions: const [
      AppColors(
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        bgColor: bgColor,
        lineColor: lineColor,
      )
    ],
  );
}

ThemeData lightTheme() {
  const Color primaryColor = Color(0xFF4E0070);
  const Color secondaryColor = Color(0xFF4C79D3);
  const Color lineColor = Colors.grey;
  const Color bgColor = Colors.white;

  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: getMaterialColor(primaryColor),
    scaffoldBackgroundColor: bgColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    dividerColor: lineColor,
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondaryColor, width: 5),
        ),
      ),
    ),
    extensions: const [
      AppColors(
        primaryColor: primaryColor,
        secondaryColor: secondaryColor,
        bgColor: bgColor,
        lineColor: lineColor,
      )
    ],
  );
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
