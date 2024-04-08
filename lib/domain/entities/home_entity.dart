import 'package:equatable/equatable.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:uuid/uuid.dart';

/// An instance of a home or destination you wanna go to.
class HomeEntity extends Equatable {
  final String id;
  final String name;
  final String city;
  final String street;
  final String streetNumber;
  final String postcode;
  final StationEntity mainStation;

  const HomeEntity({
    required this.id,
    required this.name,
    required this.city,
    required this.street,
    required this.streetNumber,
    required this.postcode,
    required this.mainStation,
  });

  HomeEntity copyWith({
    String? id,
    String? name,
    String? city,
    String? street,
    String? streetNumber,
    String? postcode,
    StationEntity? mainStation,
  }) {
    return HomeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      street: street ?? this.street,
      streetNumber: streetNumber ?? this.streetNumber,
      postcode: postcode ?? this.postcode,
      mainStation: mainStation ?? this.mainStation,
    );
  }

  factory HomeEntity.empty() {
    return HomeEntity(
      id: const Uuid().v4(),
      name: '',
      city: '',
      street: '',
      streetNumber: '',
      postcode: '',
      mainStation: const StationEntity.empty(),
    );
  }

  @override
  List<Object> get props {
    return [id, name, city, street, streetNumber, postcode, mainStation];
  }
}
