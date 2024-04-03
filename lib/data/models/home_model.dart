import 'package:take_me_home/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.name,
    required super.city,
    required super.street,
    required super.streetNumber,
    required super.postcode,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> jsonBody = json['body'];

    return HomeModel(
      id: json['id'] as String,
      name: jsonBody['name'] as String,
      city: jsonBody['city'] as String,
      street: jsonBody['street'] as String,
      streetNumber: jsonBody['streetNumber'] as String,
      postcode: jsonBody['postcode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': {
        'name': name,
        'city': city,
        'street': street,
        'streetNumber': streetNumber,
        'postcode': postcode,
      },
    };
  }

  factory HomeModel.fromEntity(HomeEntity entity) {
    return HomeModel(
      id: entity.id,
      name: entity.name,
      city: entity.city,
      street: entity.street,
      streetNumber: entity.streetNumber,
      postcode: entity.postcode,
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      name: name,
      city: city,
      street: street,
      streetNumber: streetNumber,
      postcode: postcode,
    );
  }
}
