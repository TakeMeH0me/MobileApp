import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_me_home/core/error/exception.dart';
import 'package:take_me_home/data/models/home_model.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';

/// Home (Destination of the route) Remote Data Source.
abstract class HomeRemoteDataSource {
  /// The [home] is created in the remote data source and the id has to be set.
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> createHome(HomeEntity home);

  /// Returns a [Stream] of all [HomeEntity]s that can be listened to.
  ///
  /// Throws an [APIException] for all error codes.
  Stream<List<HomeEntity>> getAllHomes();

  /// The [home] is updated in the remote data source.
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> updateHome(HomeEntity home);

  /// The [home] is deleted in the remote data source.
  ///
  /// Throws an [APIException] for all error codes.
  Future<void> deleteHome(HomeEntity home);
}

/// Implementation of the [HomeRemoteDataSource] interface for Supabase.
class SupabaseHomeRemoteDataSource implements HomeRemoteDataSource {
  final SupabaseClient client;

  SupabaseHomeRemoteDataSource({required this.client});

  final String homesDatabaseName = 'homes';

  @override
  Future<void> createHome(HomeEntity home) async {
    final homeAsJson = HomeModel.fromEntity(home).toJson();
    final response = await client.from(homesDatabaseName).insert(homeAsJson);

    if (response.error != null) {
      throw APIException(
          message: 'Error creating home: ${response.error!.message}');
    }
  }

  @override
  Future<void> deleteHome(HomeEntity home) async {
    final response = await client.from(homesDatabaseName).delete().eq(
          'id',
          home.id,
        );

    if (response.error != null) {
      throw APIException(
          message: 'Error deleting home: ${response.error!.message}');
    }
  }

  @override
  Stream<List<HomeEntity>> getAllHomes() {
    try {
      const List<String> notifiedColumns = [
        'id',
        'body:name',
        'body:city',
        'body:street',
        'body:streetNumber',
        'body:postcode'
      ];

      final homeStreamAsJson =
          client.from(homesDatabaseName).stream(primaryKey: notifiedColumns);

      return homeStreamAsJson.map((homesAsJson) => homesAsJson
          .map((homeAsJson) => HomeModel.fromJson(homeAsJson))
          .toList());
    } catch (e) {
      throw APIException(message: 'Error getting all homes: $e');
    }
  }

  @override
  Future<void> updateHome(HomeEntity home) async {
    final homeAsJson = HomeModel.fromEntity(home).toJson();

    final response = await client
        .from(homesDatabaseName)
        .update(homeAsJson)
        .eq('id', home.id);

    if (response.error != null) {
      throw APIException(
          message: 'Error updating home: ${response.error!.message}');
    }
  }
}
