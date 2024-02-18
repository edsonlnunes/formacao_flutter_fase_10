import 'package:flutter/material.dart';

import '../../../../shared/entities/release.entity.dart';
import '../../../../themes/app_colors.dart';
import 'release_tile.widget.dart';

class ReleaseListTile extends StatelessWidget {
  final List<Release> releases;

  const ReleaseListTile({super.key, required this.releases});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Todos os lançamentos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 1),
        Expanded(
          child: ListView.builder(
            itemCount: releases.length,
            itemBuilder: (context, index) {
              final release = releases[index];

              return ReleaseTile(
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
