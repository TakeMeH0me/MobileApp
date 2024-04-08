import 'package:flutter/material.dart';

import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/presentation/pages/pages.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';

/// Wrapper for the [MainApp].
/// Controls logic for stuff like tabs, etc.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateOrEditHome(context);
        },
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
        child: ShowHomesPage(),
      ),
    );
  }

  void _navigateToCreateOrEditHome(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRouter.createOrEditHome,
      arguments: CreateOrEditHomeArgs(
        home: HomeEntity.empty(),
        isNewHome: false,
      ),
    );
  }
}
