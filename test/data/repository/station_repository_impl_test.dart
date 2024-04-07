import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_me_home/core/error/exception.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/core/network/network_info.dart';
import 'package:take_me_home/data/data_sources/station_remote_data_source.dart';
import 'package:take_me_home/data/repository/station_repository_impl.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/domain/repository/station_repository.dart';

class MockStationRemoteDataSource extends Mock
    implements StationRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late StationRepository repository;
  late MockStationRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockStationRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = StationRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tStationEntity = StationEntity(
    id: '8012657',
    name: 'Pößneck ob Bf',
  );
  const tTimeOfDay = TimeOfDay(hour: 18, minute: 0);
  const tMeansOfTransportEntity = MeansOfTransportEntity(
    name: 'RE 1',
    departureTime: TimeOfDay(hour: 0, minute: 0),
    isCancelled: false,
    delayInMinutes: 0,
  );

  setUpAll(() {
    registerFallbackValue(tStationEntity);
    registerFallbackValue(tTimeOfDay);
    registerFallbackValue(tMeansOfTransportEntity);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('getMeansOfTransportByTime()', () {
    const List<MeansOfTransportEntity> tListOfMOT = [
      tMeansOfTransportEntity,
      tMeansOfTransportEntity,
    ];

    test(
      'Should check if the device is online.',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getMeansOfTransportByTime(any(), any()))
            .thenAnswer((_) async => []);
        // act
        repository.getMeansOfTransportByTime(tStationEntity, tTimeOfDay);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'Should return Right(List<MeansOfTransportEntity>) when the call to remote data source is successful.',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getMeansOfTransportByTime(
                any(),
                any(),
              )).thenAnswer((_) async => tListOfMOT);

          // act
          final actual = await repository.getMeansOfTransportByTime(
            tStationEntity,
            tTimeOfDay,
          );

          // assert
          expect(actual, equals(const Right(tListOfMOT)));
        },
      );

      test(
        'Should return Left(APIFailure) when the call to remote data source is unsuccessful.',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getMeansOfTransportByTime(
                any(),
                any(),
              )).thenThrow(APIException(message: 'test'));
          // act
          final actual = await repository.getMeansOfTransportByTime(
            tStationEntity,
            tTimeOfDay,
          );

          // assert
          expect(actual, equals(Left(APIFailure())));
        },
      );
    });
  });
}
