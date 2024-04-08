import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_me_home/injection_container.dart' as injection_container;
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

void main() async {
  // otherwise the app will crash
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jwshteklvcefnkdbojxs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3c2h0ZWtsdmNlZm5rZGJvanhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIxNjkwNTIsImV4cCI6MjAyNzc0NTA1Mn0.TO0qCLCW-s1EjbYKn0Zf0OvbKgPuUCsjEgnYJh0wg-M',
  );
  await injection_container.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injection_container.sl<StationBloc>(),
        ),
        BlocProvider(
          create: (context) => injection_container.sl<HomeBloc>(),
        ),
      ],
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

  static const String title = 'Take Me Home';
  static const String appGroupId = 'group.takemehome';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MainApp.title,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.root,
      onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
      darkTheme: darkoColorTheme,
      theme: lightColorTheme,
    );
  }
}
