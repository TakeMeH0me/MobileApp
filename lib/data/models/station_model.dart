import 'package:take_me_home/domain/entities/station_entity.dart';

class StationModel extends StationEntity {
  const StationModel({
    required super.id,
    required super.name,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory StationModel.fromEntity(StationEntity entity) {
    return StationModel(
      id: entity.id,
      name: entity.name,
    );
  }

  StationEntity toEntity() {
    return StationEntity(
      id: id,
      name: name,
    );
  }
}
