import 'package:take_me_home/presentation/helper/time_transformer.dart';

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
      '"entranceTime"': '"${TimeTransformer.toFullIso8601(entranceTime)}"',
      '"exit"': '"$exit"',
      '"exitTime"': '"${TimeTransformer.toFullIso8601(exitTime)}"',
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
