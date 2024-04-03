import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_me_home/data/models/home_model.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';

abstract class HomeRemoteDataSource {
  Stream<List<HomeEntity>> getAllHomes();
  Future<void> createHome(HomeEntity home);
  Future<void> updateHome(HomeEntity home);
  Future<void> deleteHome(HomeEntity home);
}

class SupabaseHomeRemoteDataSource implements HomeRemoteDataSource {
  final SupabaseClient client;

  SupabaseHomeRemoteDataSource({required this.client});

  final String homesDatabaseName = 'homes';

  @override
  Future<void> createHome(HomeEntity home) async {
    final homeAsJson = HomeModel.fromEntity(home).toJson();
    await client.from(homesDatabaseName).insert(homeAsJson);
  }

  @override
  Future<void> deleteHome(HomeEntity home) async {
    await client.from(homesDatabaseName).delete().eq('id', home.id);
  }

  @override
  Stream<List<HomeEntity>> getAllHomes() {
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
  }

  @override
  Future<void> updateHome(HomeEntity home) async {
    final homeAsJson = HomeModel.fromEntity(home).toJson();

    await client.from(homesDatabaseName).update(homeAsJson).eq('id', home.id);
  }
}
