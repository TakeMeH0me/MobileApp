import 'package:take_me_home/presentation/helper/time_transformer.dart';
import 'package:take_me_home/presentation/homewidget/route_part.dart';

class RouteInformation {
  DateTime date;
  List<RoutePart> route;

  RouteInformation({required this.date, required this.route});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> routeJson = [];

    for (var routePart in route) {
      routeJson.add(routePart.toJson());
    }

    return {
      '"date"': '"${TimeTransformer.toFullIso8601(date)}"',
      '"route"': routeJson,
    };
  }
}
