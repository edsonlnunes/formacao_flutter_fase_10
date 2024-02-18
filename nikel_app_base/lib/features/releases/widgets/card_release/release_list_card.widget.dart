import 'package:flutter/material.dart';

import '../../../../shared/entities/release.entity.dart';
import 'release_card.widget.dart';

class ReleaseListCard extends StatelessWidget {
  final bool isInflow;
  final List<Release> releases;

  const ReleaseListCard({
    super.key,
    this.isInflow = true,
    required this.releases,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              isInflow ? 'Entradas' : 'Saída',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              isInflow
                  ? Icons.arrow_circle_down_outlined
                  : Icons.arrow_circle_up_outlined,
              size: 34,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 1),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemCount: releases.length,
            itemBuilder: (context, index) {
              final release = releases[index];

              return ReleaseCard(
                value: release.value,
                description: release.description,
                date: release.date,
                isInflow: release.isInflow,
              );
            },
          ),
        ),
      ],
    );
  }
}
