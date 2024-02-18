import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color lineColor;
  final Color bgColor;

  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.lineColor,
    required this.bgColor,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? lineColor,
    Color? bgColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      lineColor: lineColor ?? this.lineColor,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      lineColor: Color.lerp(lineColor, other.lineColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
    );
  }
}
