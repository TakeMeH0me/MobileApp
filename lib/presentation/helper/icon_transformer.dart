import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

class MeansOfTransportTransportTransformer {
  static IconData getTypeAsIconData(MeansOfTransportType type) {
    switch (type) {
      case MeansOfTransportType.bus:
        return Icons.directions_bus;
      case MeansOfTransportType.train:
        return Icons.train;
      case MeansOfTransportType.tram:
        return Icons.tram;
      case MeansOfTransportType.walk:
        return Icons.directions_walk;
      case MeansOfTransportType.unknown:
        return Icons.question_mark;
    }
  }

  static String getTypeAsString(MeansOfTransportType type) {
    switch (type) {
      case MeansOfTransportType.bus:
        return 'Bus';
      case MeansOfTransportType.train:
        return 'Zug';
      case MeansOfTransportType.tram:
        return 'Straßenbahn';
      case MeansOfTransportType.walk:
        return 'Zu Fuß';
      case MeansOfTransportType.unknown:
        return 'Unbekannt';
    }
  }
}
