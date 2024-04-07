import 'package:flutter/material.dart';

import 'package:take_me_home/app.dart';
import 'package:take_me_home/presentation/pages/pages.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';
import 'package:take_me_home/presentation/router/args/edit_means_of_transport_card_args.dart';
import 'package:take_me_home/presentation/router/args/show_way_to_home_args.dart';

/// Lets you route between different pages in the app.
class AppRouter {
  static const String root = '/';
  static const String createOrEditHome = '/create_or_edit_home';
  static const String showWayToHome = '/show_way_to_home';
  static const String editMeansOfTransportCard =
      '/show_way_to_home/edit_means_of_transport_card';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const App());
      case createOrEditHome:
        final args = settings.arguments as CreateOrEditHomeArgs;

        return MaterialPageRoute(
          builder: (_) => CreateOrEditHomePage(
            home: args.home,
            isNewHome: args.isNewHome,
          ),
        );
      case showWayToHome:
        final args = settings.arguments as ShowWayToHomeArgs;

        return MaterialPageRoute(
          builder: (_) => ShowWayToHomePage(
            home: args.home,
          ),
        );
      case editMeansOfTransportCard:
        final args = settings.arguments as EditMeansOfTransportCardArgs;

        return MaterialPageRoute(
          builder: (_) => EditMeansOfTransportCardPage(
            meansOfTransport: args.meansOfTransport,
            duration: args.duration,
          ),
        );
      default:
        return null;
    }
  }
}
