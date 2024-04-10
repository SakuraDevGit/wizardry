// I want a dart model that will extend HouseEntity with an EquatableMixin.
// I want a factory constructor that will take a json map and return a HouseModel.
// This SpellModel class must be similar to the HouseModel class.

import 'package:equatable/equatable.dart';
import 'package:domain/entities/spell_entities/spell_entity.dart';

class SpellModel extends SpellEntity with EquatableMixin {
  SpellModel({
    required super.id,
    required super.name,
    required super.incantation,
    required super.effect,
    required super.canBeVerbal,
    required super.type,
    required super.light,
    required super.creator,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      id: json['id'] as String? ?? 'invalid_id',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      effect: json['effect'] as String? ?? '',
      incantation: json['incantation'] as String? ?? '',
      canBeVerbal: json['canBeVerbal'] as bool? ?? false,
      light: json['light'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id];
}
