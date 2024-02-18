import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../themes/app_colors.dart';

class ReleaseTile extends StatelessWidget {
  final double value;
  final DateTime date;
  final String description;
  final bool isInflow;

  const ReleaseTile({
    super.key,
    required this.date,
    required this.value,
    required this.isInflow,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: appColors.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(right: 120),
                  child: Text(
                    description,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '${isInflow ? '+' : '-'}R\$ ${value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isInflow ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
