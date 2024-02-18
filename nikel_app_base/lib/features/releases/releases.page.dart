import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../settings/views/settings.page.dart';
import 'releases.store.dart';
import 'widgets/add_release/add_release.widget.dart';
import 'widgets/card_release/card_release_subpage.widget.dart';
import 'widgets/list_release/list_release_subpage.widget.dart';

class ReleasesPage extends StatefulWidget {
  const ReleasesPage({super.key});

  @override
  State<ReleasesPage> createState() => _ReleasesPageState();
}

class _ReleasesPageState extends State<ReleasesPage> {
  final store = ReleasesStore(GetIt.I(), GetIt.I());

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async => await store.getReleases());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/nikel_logo.png',
            width: 70,
            color: theme.brightness == Brightness.dark ? null : Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.white,
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CardReleaseSubPage(
              store: store,
            ),
            ListReleaseSubPage(
              store: store,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddRelease(
                  walletBalance: store.walletBalance,
                  addReleaseInList: store.addReleaseInList,
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
