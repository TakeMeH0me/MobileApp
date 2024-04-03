import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:take_me_home/injection_container.dart' as injection_container;
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

void main() async {
  await injection_container.init();

  runApp(
    BlocProvider(
      create: (context) => injection_container.sl<StationBloc>(),
      child: MainApp(
        appRouter: injection_container.sl(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;

  const MainApp({
    required this.appRouter,
    super.key,
  });

  static String get title => 'Take Me Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MainApp.title,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.root,
      onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      theme: ThemeData(colorScheme: lightColorScheme),
    );
  }
}
