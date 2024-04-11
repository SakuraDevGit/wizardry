import 'package:domain/entities/spell_entities/spell_entity.dart';

class SpellModel extends SpellEntity {
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
}
