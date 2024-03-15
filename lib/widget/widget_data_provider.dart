class RouteInformation {
  DateTime time;
  List<RoutePart> route;

  RouteInformation({
    required this.time,
    required this.route,
  });
}

class RoutePart {
  DateTime from;
  DateTime to;
  Vehicle transport;
  String connectionName;

  RoutePart({
    required this.from,
    required this.to,
    required this.transport,
    required this.connectionName,
  });
}

enum Vehicle {
  unknown,
  walk,
  train,
  bus,
}
