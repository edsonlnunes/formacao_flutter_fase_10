import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class ConsolidatedValue extends StatelessWidget {
  final double amountValue;
  final bool isLoading;
  const ConsolidatedValue({
    super.key,
    required this.amountValue,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    return Container(
      color: theme.brightness == Brightness.dark
          ? appColors.primaryColor
          : appColors.secondaryColor,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image.asset(
            'assets/images/cash_coin.png',
            width: 40,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          isLoading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  'R\$ $amountValue',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const Spacer(),
          Image.asset(
            'assets/images/coins_icon.png',
            width: 90,
          ),
        ],
      ),
    );
  }
}
