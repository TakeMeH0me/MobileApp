import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/domain/usecase/station/station_route_usecase.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final GetStationRouteUseCase getStationRouteUseCase;

  StationBloc({required this.getStationRouteUseCase})
      : super(StationInitial()) {
    on<GetMeansOfTransportByTime>(_onGetMeansOfTransportByTime);
  }

  void _onGetMeansOfTransportByTime(
    GetMeansOfTransportByTime event,
    Emitter<StationState> emit,
  ) async {
    emit(StationLoading());

    final result = await getStationRouteUseCase.execute(
      event.startStation,
      event.endStation,
      event.startTime,
      event.endTime,
    );

    result.fold(
      (failure) => emit(
        const StationError('Error while loading means of transport.'),
      ),
      (wasWorking) {
        if (!wasWorking) {
          emit(const StationError('It was not working.'));
          return;
        }

        emit(StationsUpdated(
          stations: getStationRouteUseCase.currentStations,
          meansOfTransportEntities:
              getStationRouteUseCase.currentMeansOfTransport,
        ));
      },
    );
  }
}
