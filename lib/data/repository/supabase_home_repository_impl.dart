import 'package:dartz/dartz.dart';
import 'package:take_me_home/core/error/exception.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/core/network/network_info.dart';
import 'package:take_me_home/data/data_sources/home_remote_data_source.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/repository/home_repository.dart';

/// Implementation of the [HomeRepository] interface.
class SupabaseHomeRepositoryImpl implements HomeRepository {
  final SupabaseHomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SupabaseHomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> createHome(HomeEntity home) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createHome(home);
        return const Right(null);
      } on APIException catch (_) {
        return Left(APIFailure());
      }
    }

    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, Stream<List<HomeEntity>>>> getAllHomes() async {
    if (await networkInfo.isConnected) {
      try {
        final Stream<List<HomeEntity>> allHomesStream =
            remoteDataSource.getAllHomes();
        return Right(allHomesStream);
      } on APIException catch (_) {
        return Left(APIFailure());
      }
    }

    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, void>> updateHome(HomeEntity home) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateHome(home);
        return const Right(null);
      } on APIException catch (_) {
        return Left(APIFailure());
      }
    }

    return Left(APIFailure());
  }

  @override
  Future<Either<Failure, void>> deleteHome(HomeEntity home) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteHome(home);
        return const Right(null);
      } on APIException catch (_) {
        return Left(APIFailure());
      }
    }

    return Left(APIFailure());
  }
}
