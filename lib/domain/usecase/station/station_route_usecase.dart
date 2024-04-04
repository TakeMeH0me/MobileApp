import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/domain/repository/station_repository.dart';

class GetStationRouteUseCase {
  final StationRepository stationRepository;
  final List<StationEntity> _currentStations = [];
  final List<MeansOfTransportEntity> _currentMeansOfTransport = [];

  GetStationRouteUseCase({required this.stationRepository});

  // final String preferredTrainNamePoessneck = 'RE 80851';
  // final String preferredTrainNamePoessneck = 'RB 80862';
  // final String preferredTrainNamePoessneck = 'RB 80857';
  final String preferredTrainNamePoessneck = 'RE 80859';

  List<StationEntity> get currentStations => _currentStations;
  List<MeansOfTransportEntity> get currentMeansOfTransport =>
      _currentMeansOfTransport;

// hier davor bisschen laufen
  // vom Start alles holem
  // vom Ziel alles holen (da wo home ist)
  // hier danach bisschen laufen

  Future<Either<Failure, bool>> execute(
    StationEntity startStation,
    StationEntity endStation,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) async {
    _currentStations.clear();
    _currentMeansOfTransport.clear();

    final resultFromStartStation =
        await stationRepository.getMeansOfTransportByTime(
      startStation,
      startTime,
    );

    resultFromStartStation.fold(
      (failure) {
        return failure;
      },
      (meansOfTransportEntities) async {
        final MeansOfTransportEntity? nextMeansOfTransport =
            _getCorrectMeansOfTransport(meansOfTransportEntities);
        if (nextMeansOfTransport == null) {
          return Left(APIFailure());
        }

        _currentStations.add(startStation);
        _currentMeansOfTransport.add(nextMeansOfTransport);
      },
    );

    final resultForHomeStation =
        await stationRepository.getMeansOfTransportByTime(endStation, endTime);
    resultForHomeStation.fold(
      (failure) {
        return failure;
      },
      (meansOfTransportEntities) {
        final MeansOfTransportEntity? nextMeansOfTransport =
            _getCorrectMeansOfTransport(meansOfTransportEntities);
        if (nextMeansOfTransport == null) {
          return Left(APIFailure());
        }

        _currentStations.add(endStation);
        _currentMeansOfTransport.add(nextMeansOfTransport);
      },
    );

    return const Right(true);
  }

  MeansOfTransportEntity? _getCorrectMeansOfTransport(
    List<MeansOfTransportEntity> meansOfTransportEntities,
  ) {
    for (final meansOfTransportEntity in meansOfTransportEntities) {
      if (meansOfTransportEntity.name == preferredTrainNamePoessneck) {
        return meansOfTransportEntity;
      }
    }

    return null;
  }
}
