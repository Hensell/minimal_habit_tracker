import 'package:flutter/material.dart';

import '../../../data/database/database_provider.dart';
import '../home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          } else {
            return Center(
                child: Text(
              AppLocalizations.of(context)!.welcome,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ));
          }
        },
      ),
    );
  }

  Future<void> _initializeApp() async {
    await DatabaseProvider.database;
  }
}
