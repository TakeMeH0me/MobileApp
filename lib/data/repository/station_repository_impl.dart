import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:take_me_home/core/error/exception.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/core/network/network_info.dart';
import 'package:take_me_home/data/data_sources/station_remote_data_source.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/domain/repository/station_repository.dart';

class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MeansOfTransportEntity>>>
      getMeansOfTransportByTime(StationEntity station, TimeOfDay time) async {
    if (await networkInfo.isConnected) {
      try {
        final List<MeansOfTransportEntity> meansOfTransportEntities =
            await remoteDataSource.getMeansOfTransportByTime(station, time);
        return Right(meansOfTransportEntities);
      } on APIException catch (_) {
        return Left(APIFailure());
      }
    }

    return Left(APIFailure());
  }
}
