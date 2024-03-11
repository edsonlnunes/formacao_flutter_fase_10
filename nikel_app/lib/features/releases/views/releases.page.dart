import 'package:flutter/material.dart';

import '../../../shared/views/widgets/nikel_logo.widget.dart';
import '../../../theme/app_colors.dart';
import 'releases.store.dart';
import 'widgets/card_releases/card_releses_subpage.widget.dart';
import 'widgets/list_releases/list_releases_subpage.widget.dart';

class ReleasesPage extends StatelessWidget {
  final store = ReleasesStore();

  ReleasesPage({super.key}) {
    store.loadWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const NikelLogo(width: 70),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: theme.brightness == Brightness.dark
                      ? appColors.primaryColor
                      : appColors.secondaryColor,
                ),
              ),
              Tab(
                child: Image.asset(
                  'assets/images/exchange_icon.png',
                  width: 30,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CardReleasesSubPage(store: store),
            ListReleasesSubPage(store: store),
          ],
        ),
      ),
    );
  }
}
