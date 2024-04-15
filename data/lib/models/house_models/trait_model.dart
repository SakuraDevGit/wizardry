import 'package:domain/entities/house_entities/trait_entity.dart';

class TraitModel extends TraitEntity {
  TraitModel({
    required super.id,
    required super.name,
  });

  factory TraitModel.fromJson(Map<String, dynamic> json) {
    return TraitModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
