part of 'station_bloc.dart';

sealed class StationState extends Equatable {
  const StationState();

  @override
  List<Object> get props => [];
}

final class StationInitial extends StationState {}

final class StationLoading extends StationState {}

final class StationsUpdated extends StationState {
  final List<StationEntity> stations;
  final List<MeansOfTransportEntity> meansOfTransportEntities;

  const StationsUpdated({
    required this.stations,
    required this.meansOfTransportEntities,
  });

  @override
  List<Object> get props => [meansOfTransportEntities];
}

final class StationError extends StationState {
  final String message;

  const StationError(this.message);

  @override
  List<Object> get props => [message];
}
