import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

class IconTransformer {
  static IconData fromMeansOfTransportType(
      MeansOfTransportType iconIdentifier) {
    switch (iconIdentifier) {
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
}
