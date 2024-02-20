import 'package:flutter/material.dart';

import '../../app.dart';
import '../pages/pages.dart';

/// Lets you route between different pages in the app.
class AppRouter {
  static const String root = '/';
  static const String createOrEditHome = '/create_or_edit_home';
  static const String showWayToHome = '/show_way_to_home';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const App());
      case createOrEditHome:
        return MaterialPageRoute(
          builder: (_) => const CreateOrEditHomePage(isEditing: false),
        );
      case showWayToHome:
        return MaterialPageRoute(builder: (_) => const ShowWayToHomePage());
      default:
        return null;
    }
  }
}
