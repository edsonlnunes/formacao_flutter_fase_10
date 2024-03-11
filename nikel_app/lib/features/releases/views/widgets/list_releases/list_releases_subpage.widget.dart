import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../releases.store.dart';
import '../consolidated_value.widget.dart';

class ListReleasesSubPage extends StatelessWidget {
  final ReleasesStore store;
  const ListReleasesSubPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return ConsolidatedValue(
              amountValue: store.walletBalance,
              isLoading: store.isLoadingBalance,
            );
          },
        ),
      ],
    );
  }
}
