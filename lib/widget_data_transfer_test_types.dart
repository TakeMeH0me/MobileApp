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
      '"date"': '"${parseToIso8601(date)}"',
      '"route"': routeJson,
    };
  }
}

class RoutePart {
  VehicleType vehicle;
  String lineName;
  String lineDestination;
  String entrance;
  DateTime entranceTime;
  String exit;
  DateTime exitTime;

  RoutePart({
    required this.vehicle,
    required this.lineName,
    required this.lineDestination,
    required this.entrance,
    required this.entranceTime,
    required this.exit,
    required this.exitTime,
  });

  Map<String, dynamic> toJson() {
    return {
      '"vehicle"': '"${vehicle.name}"',
      '"lineName"': '"$lineName"',
      '"lineDestination"': '"$lineDestination"',
      '"entrance"': '"$entrance"',
      '"entranceTime"': '"${parseToIso8601(entranceTime)}"',
      '"exit"': '"$exit"',
      '"exitTime"': '"${parseToIso8601(exitTime)}"',
    };
  }
}

enum VehicleType {
  unknown,
  walk,
  tram,
  train,
  bus,
}

String parseToIso8601(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}-${dateTime.day >= 10 ? dateTime.day : '0${dateTime.day}'}T${dateTime.hour >= 10 ? dateTime.hour - 2 : '0${dateTime.hour - 2}'}:${dateTime.minute >= 10 ? dateTime.minute : '0${dateTime.minute}'}:${dateTime.second >= 10 ? dateTime.second : '0${dateTime.second}'}Z';
}
