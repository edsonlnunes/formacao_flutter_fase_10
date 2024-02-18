import 'package:flutter/material.dart';

class LogoGrowdev extends StatelessWidget {
  final double _width;

  const LogoGrowdev({
    super.key,
    double width = 100,
  }) : _width = width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Image.asset(
      theme.brightness == Brightness.dark
          ? 'assets/growdev_logo_light.png'
          : 'assets/growdev_logo_dark.png',
      width: _width,
    );
  }
}
