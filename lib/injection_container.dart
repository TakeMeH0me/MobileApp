import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_me_home/core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:take_me_home/data/data_sources/home_remote_data_source.dart';
import 'package:take_me_home/data/data_sources/station_remote_data_source.dart';
import 'package:take_me_home/data/repository/station_repository_impl.dart';
import 'package:take_me_home/data/repository/supabase_home_repository_impl.dart';
import 'package:take_me_home/domain/repository/home_repository.dart';
import 'package:take_me_home/domain/repository/station_repository.dart';
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';

import 'package:take_me_home/presentation/router/app_router.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<StationBloc>(() => StationBloc(
        stationRepository: sl(),
      ));
  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(
        homeRepository: sl(),
      ));

  sl.registerLazySingleton<StationRepository>(() => StationRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<HomeRepository>(() => SupabaseHomeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<StationRemoteDataSource>(
      () => StationRemoteDataSourceImpl(
            httpClient: sl(),
          ));
  sl.registerLazySingleton<SupabaseHomeRemoteDataSource>(
      () => SupabaseHomeRemoteDataSource(
            client: sl(),
          ));

  sl.registerLazySingleton(() => AppRouter());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: sl(),
      ));

  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Supabase.instance.client);
}
