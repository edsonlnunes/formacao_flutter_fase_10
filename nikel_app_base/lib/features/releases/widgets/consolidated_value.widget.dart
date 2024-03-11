import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class ConsolidatedValue extends StatelessWidget {
  final double amountBalance;
  const ConsolidatedValue({
    super.key,
    required this.amountBalance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      color: theme.brightness == Brightness.dark
          ? appColors.primaryColor
          : appColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/cash_coin.png',
                  width: 40,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'R\$ ${amountBalance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/coins_icon.png',
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}
