import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// An instance of a means of transport you wanna take. (e.g. train, bus, tram, etc.)
class MeansOfTransportEntity extends Equatable {
  final String name;
  final TimeOfDay departureTime;
  final bool isCancelled;
  final int delayInMinutes;
  final MeansOfTransportType type;

  const MeansOfTransportEntity({
    required this.name,
    required this.departureTime,
    required this.isCancelled,
    required this.delayInMinutes,
    required this.type,
  });

  bool get isDelayed => delayInMinutes > 0;

  @override
  List<Object?> get props => [
        name,
        departureTime,
        isCancelled,
        delayInMinutes,
        type,
      ];
}

enum MeansOfTransportType {
  train,
  bus,
  tram,
  unknown,
}
