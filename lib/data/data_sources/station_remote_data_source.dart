import 'package:flutter/material.dart';
import 'package:take_me_home/core/error/exception.dart';
import 'package:take_me_home/data/models/means_of_transport_model.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:http/http.dart' as http;

abstract class StationRemoteDataSource {
  /// Fetches the means of transport by time from the inofficial API for a specific hour.
  ///
  /// Throws a [APIException] for all error codes.
  Future<List<MeansOfTransportEntity>> getMeansOfTransportByTime(
      StationEntity station, TimeOfDay time);
}

/// Implementation of the [StationRemoteDataSource] interface for the inofficial Deutsche Bahn API.
///
/// Reference for more information:
/// https://hackmd.io/@SOYbid3rTROn8Sw3RQOucg/BkrWNDbT7?type=view#2-Request-Live-Timetable-with-station-from-Locationrequest-via-not-so-official-API
class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final http.Client httpClient;

  StationRemoteDataSourceImpl({required this.httpClient});

  final String baseUrl = 'https://reiseauskunft.bahn.de/bin/bhftafel.exe/dn';
  final String baseParams = 'L=vs_java&start=yes&boardType=arr';

  @override
  Future<List<MeansOfTransportEntity>> getMeansOfTransportByTime(
      StationEntity station, TimeOfDay time) async {
    final response = await httpClient.get(
      Uri.parse(
          '$baseUrl?$baseParams&time=${time.hour}:${time.minute}&input=${station.id}'),
    );

    if (response.statusCode != 200) {
      throw APIException(
        message: 'getMeansOfTransportByTime(): ${response.body}',
      );
    }

    final List<String> lines = response.body.split('\n');
    // first line just contains the header
    lines.removeAt(0);

    List<MeansOfTransportEntity> result = [];
    for (int i = 0; i < lines.length - 3; i += 3) {
      final String time = lines[i];
      final String name = lines[i + 1];
      final String delay = lines[i + 2];

      final meansOfTransportEntity = MeansOfTransportModel.fromPlainText(
        [time, name, delay],
      );
      result.add(meansOfTransportEntity);
    }

    return result;
  }
}
