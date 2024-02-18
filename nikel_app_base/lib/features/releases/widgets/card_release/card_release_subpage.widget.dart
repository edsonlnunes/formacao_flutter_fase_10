import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../themes/app_colors.dart';
import '../../releases.store.dart';
import '../consolidated_value.widget.dart';
import 'release_list_card.widget.dart';

class CardReleaseSubPage extends StatelessWidget {
  final ReleasesStore _store;
  const CardReleaseSubPage({super.key, required ReleasesStore store})
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
            padding: const EdgeInsets.all(15),
            child: Observer(
              builder: (_) {
                if (_store.isLoading) {
                  Center(
                    child: CircularProgressIndicator(
                      color: appColors.primaryColor,
                    ),
                  );
                }

                return Row(
                  children: [
                    Flexible(
                      child: ReleaseListCard(
                        releases: _store.releasesInflow,
                      ),
                    ),
                    Flexible(
                      child: ReleaseListCard(
                        isInflow: false,
                        releases: _store.releasesOutflow,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
