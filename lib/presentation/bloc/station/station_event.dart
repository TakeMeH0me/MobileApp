part of 'station_bloc.dart';

sealed class StationEvent extends Equatable {
  const StationEvent();

  @override
  List<Object> get props => [];
}

final class GetMeansOfTransportByTime extends StationEvent {
  final StationEntity startStation;
  final StationEntity endStation;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const GetMeansOfTransportByTime({
    required this.startStation,
    required this.endStation,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object> get props => [startStation, endStation, startTime, endTime];
}
