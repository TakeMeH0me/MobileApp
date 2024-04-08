import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';

/// Managing station data.
/// 
/// Look at the [StationRemoteDataSource] interface for more information.
abstract class StationRepository {
  Future<Either<Failure, List<MeansOfTransportEntity>>>
      getMeansOfTransportByTime(StationEntity station, TimeOfDay time);
}
