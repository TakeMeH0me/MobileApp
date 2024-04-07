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
        onPressed: () async {
          final HomeEntity? newHome = await Navigator.of(context).pushNamed(
            AppRouter.createOrEditHome,
            arguments: CreateOrEditHomeArgs(
              home: HomeEntity
                  .empty(), // Assuming HomeEntity.empty() is a valid constructor for a new instance
              isNewHome: true,
            ),
          ) as HomeEntity?;

          if (newHome != null) {
            // You need a mechanism here to add this `newHome` to your homes list in ShowHomesPage
            // This could be a direct method call if you have access, or an event you can fire, or using a state management solution
          }
        },
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
        child: ShowHomesPage(),
      ),
    );
  }
}
