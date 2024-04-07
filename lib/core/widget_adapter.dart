import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/widget_data_transfer_test_types.dart';

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
                  0, 0, 0, e.departureTime.hour, e.departureTime.minute),
              exit: 'Pößneck ob. Bhf',
              exitTime: DateTime(
                  0, 0, 0, e.departureTime.hour, e.departureTime.minute),
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
