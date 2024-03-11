import 'package:flutter/material.dart';

class NikelLogo extends StatelessWidget {
  final double width;
  const NikelLogo({
    super.key,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Image.asset(
      'assets/images/nikel_logo.png',
      width: width,
      color: theme.brightness == Brightness.light ? Colors.white : null,
    );
  }
}
