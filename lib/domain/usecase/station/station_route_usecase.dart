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

  // see: https://www.erfurter-bahn.de/fahrplaene-netze/fahrplaene-liniennetz/linie/re-12-rb-22-3
  final List<String> preferredTrainNamesPoessneck = [
    'RB 80875',
    'RB 80831',
    'RB 80833',
    'RB 80835',
    'RB 80837',
    'RB 81011',
    'RE 80839',
    'RB 80841',
    'RE 80843',
    'RB 80845',
    'RE 80847',
    'RB 80849',
    'RE 80851',
    'RB 80853',
    'RB 80877',
    'RE 80855',
    'RB 80857',
    'RE 80859',
    'RB 80861',
    'RB 80863',
    'RE 80865',
    'RB 80869',
    'RB 80871',
  ];

  List<StationEntity> get currentStations => _currentStations;
  List<MeansOfTransportEntity> get currentMeansOfTransport =>
      _currentMeansOfTransport;

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
      if (preferredTrainNamesPoessneck.contains(meansOfTransportEntity.name)) {
        return meansOfTransportEntity;
      }
    }

    return null;
  }
}
