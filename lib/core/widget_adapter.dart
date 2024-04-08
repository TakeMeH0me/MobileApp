import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/presentation/homewidget/route_information.dart';
import 'package:take_me_home/presentation/homewidget/route_part.dart';

/// This adapter is for converting the entities used in the app to the entities
/// used in the widgets for the Homescreen of the smartphone.
/// The reason for this is that we worked with different entities in the app
/// and the widgets.
class RouteInformationAdapter {
  static RouteInformation toRouteInformation(
      List<MeansOfTransportEntity> meansOfTransportEntity) {
    return RouteInformation(
      date: DateTime.now(),
      route: meansOfTransportEntity
          .map(
            (e) => RoutePart(
              vehicle: toVehicleType(e.type),
              lineName: e.name,
              lineDestination: 'Saalfeld(Saale) Hbf',
              entrance: 'Gera Hbf',
              entranceTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  e.departureTime.hour,
                  e.departureTime.minute),
              exit: 'Pößneck ob. Bhf',
              exitTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  e.departureTime.hour,
                  e.departureTime.minute),
            ),
          )
          .toList(),
    );
  }

  static VehicleType toVehicleType(MeansOfTransportType meansOfTransportType) {
    switch (meansOfTransportType) {
      case MeansOfTransportType.bus:
        return VehicleType.bus;
      case MeansOfTransportType.tram:
        return VehicleType.tram;
      case MeansOfTransportType.train:
        return VehicleType.train;
      case MeansOfTransportType.walk:
        return VehicleType.walk;
      case MeansOfTransportType.unknown:
        return VehicleType.unknown;
    }
  }
}
