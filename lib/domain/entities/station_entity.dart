import 'package:equatable/equatable.dart';

/// An instance of a station you wanna start from or go to.
///
/// The [id] is the same as the ibnr of the station: https://de.wikipedia.org/wiki/Interne_Bahnhofsnummer
class StationEntity extends Equatable {
  final String id;
  final String name;

  const StationEntity({
    required this.id,
    required this.name,
  });

  StationEntity copyWith({
    String? id,
    String? name,
  }) {
    return StationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  const StationEntity.empty()
      : id = '',
        name = '';

  @override
  List<Object?> get props => [id, name];
}
