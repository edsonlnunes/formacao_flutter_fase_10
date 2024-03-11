import 'package:flutter/material.dart';

import '../../../shared/views/widgets/growdev_logo.widget.dart';
import '../../authentication/views/login/login.page.dart';
import '../../releases/views/releases.page.dart';
import 'splash.store.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final splashStore = SplashStore();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final isAuthenticated = await splashStore.userIsAuthenticated();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return isAuthenticated ? ReleasesPage() : const LoginPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            GrowdevLogo(),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
