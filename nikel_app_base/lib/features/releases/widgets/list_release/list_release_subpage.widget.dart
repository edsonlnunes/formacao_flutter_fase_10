import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../themes/app_colors.dart';
import '../../releases.store.dart';
import '../consolidated_value.widget.dart';
import 'release_list_tile.widget.dart';

class ListReleaseSubPage extends StatelessWidget {
  final ReleasesStore _store;
  const ListReleaseSubPage({super.key, required ReleasesStore store})
      : _store = store;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      children: [
        Observer(
          builder: (context) {
            return ConsolidatedValue(
              amountBalance: _store.walletBalance,
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Observer(
              builder: (_) {
                if (_store.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: appColors.primaryColor,
                    ),
                  );
                }

                return ReleaseListTile(
                  releases: _store.allReleases(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
