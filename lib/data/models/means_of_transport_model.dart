import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

class MeansOfTransportModel extends MeansOfTransportEntity {
  const MeansOfTransportModel({
    required String name,
    required TimeOfDay departureTime,
    required bool isCancelled,
    required int delayInMinutes,
    required MeansOfTransportType type,
  }) : super(
          name: name,
          departureTime: departureTime,
          isCancelled: isCancelled,
          delayInMinutes: delayInMinutes,
          type: type,
        );

  factory MeansOfTransportModel.fromPlainText(List<String> input) {
    final TimeOfDay departureTime = _getDepartureTimeFromString(input[0]);
    final String name = input[1];
    final MeansOfTransportType type = _getMeansOfTransportTypeFromString(name);

    final String delayInformationAsString = input[2];
    // TODO: Refactor this to use strategy pattern?
    if (delayInformationAsString == 'cancel') {
      return MeansOfTransportModel(
        name: name,
        departureTime: departureTime,
        isCancelled: true,
        delayInMinutes: 0,
        type: type,
      );
    } else if (delayInformationAsString == 'no') {
      return MeansOfTransportModel(
        name: name,
        departureTime: departureTime,
        isCancelled: false,
        delayInMinutes: 0,
        type: type,
      );
    } else {
      int delayInMinutes = 0;
      if (delayInformationAsString.startsWith('+')) {
        delayInMinutes = int.parse(delayInformationAsString.substring(2));
      } else {
        delayInMinutes = int.parse(delayInformationAsString);
      }

      return MeansOfTransportModel(
        name: name,
        departureTime: departureTime,
        isCancelled: false,
        delayInMinutes: delayInMinutes,
        type: type,
      );
    }
  }

  static TimeOfDay _getDepartureTimeFromString(String departureTimeAsString) {
    final List<String> splitInput = departureTimeAsString.split(':');
    return TimeOfDay(
      hour: int.parse(splitInput[0]),
      minute: int.parse(splitInput[1]),
    );
  }

  static MeansOfTransportType _getMeansOfTransportTypeFromString(
      String trainName) {
    if (trainName.startsWith('RE') ||
        trainName.startsWith('RB') ||
        trainName.startsWith('IC') ||
        trainName.startsWith('ICE')) {
      return MeansOfTransportType.train;
    }
    if (trainName.startsWith('S')) {
      return MeansOfTransportType.tram;
    }
    if (trainName.contains('Bus')) {
      return MeansOfTransportType.bus;
    }

    return MeansOfTransportType.unknown;
  }
}
