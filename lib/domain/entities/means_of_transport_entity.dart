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

  MeansOfTransportEntity copyWith({
    String? name,
    TimeOfDay? departureTime,
    bool? isCancelled,
    int? delayInMinutes,
    MeansOfTransportType? type,
  }) {
    return MeansOfTransportEntity(
      name: name ?? '',
      departureTime: departureTime ?? const TimeOfDay(hour: 0, minute: 0),
      isCancelled: isCancelled ?? false,
      delayInMinutes: delayInMinutes ?? 0,
      type: type ?? MeansOfTransportType.unknown,
    );
  }

  factory MeansOfTransportEntity.empty() {
    return const MeansOfTransportEntity(
      name: '',
      departureTime: TimeOfDay(hour: 0, minute: 0),
      isCancelled: false,
      delayInMinutes: 0,
      type: MeansOfTransportType.unknown,
    );
  }

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
  walk,
  unknown,
}
