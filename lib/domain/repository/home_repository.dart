import 'package:dartz/dartz.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';

/// Interface for the [HomeRepository] repository.
///
/// Look at the [HomeRemoteDataSource] interface for more information.
abstract class HomeRepository {
  Future<Either<Failure, void>> createHome(HomeEntity home);
  Future<Either<Failure, Stream<List<HomeEntity>>>> getAllHomes();
  Future<Either<Failure, void>> updateHome(HomeEntity home);
  Future<Either<Failure, void>> deleteHome(HomeEntity home);
}
