import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';

/// Managing station data from the inofficial API.
///
/// Reference: https://hackmd.io/@SOYbid3rTROn8Sw3RQOucg/BkrWNDbT7?type=view#2-Request-Live-Timetable-with-station-from-Locationrequest-via-not-so-official-API
abstract class StationRepository {
  Future<Either<Failure, List<MeansOfTransportEntity>>>
      getMeansOfTransportByTime(StationEntity station, TimeOfDay time);
}
