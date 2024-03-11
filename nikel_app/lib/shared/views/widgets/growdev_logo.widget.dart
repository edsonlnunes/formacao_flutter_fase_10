import 'package:flutter/material.dart';

class GrowdevLogo extends StatelessWidget {
  const GrowdevLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Image.asset(
      theme.brightness == Brightness.light
          ? 'assets/images/growdev_logo_dark.png'
          : 'assets/images/growdev_logo_light.png',
      width: 100,
    );
  }
}
