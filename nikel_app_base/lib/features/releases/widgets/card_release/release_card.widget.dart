import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../themes/app_colors.dart';

class ReleaseCard extends StatelessWidget {
  final double value;
  final String description;
  final DateTime date;
  final bool isInflow;

  const ReleaseCard({
    super.key,
    required this.value,
    required this.description,
    required this.date,
    required this.isInflow,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: isInflow
          ? const EdgeInsets.only(right: 2.5)
          : const EdgeInsets.only(left: 2.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: appColors.lineColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${isInflow ? '+' : '-'}R\$ ${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isInflow ? Colors.green : Colors.red,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              maxLines: 2,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
