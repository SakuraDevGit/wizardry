import 'package:data/models/house_models/head_model.dart';
import 'package:data/models/house_models/trait_model.dart';
import 'package:domain/entities/house_entities/house_entity.dart';

class HouseModel extends HouseEntity {
  HouseModel({
    required super.id,
    required super.name,
    required super.houseColours,
    required super.founder,
    required super.animal,
    required super.element,
    required super.ghost,
    required super.commonRoom,
    required super.heads,
    required super.traits,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      name: json['name'],
      houseColours: json['houseColours'],
      founder: json['founder'],
      animal: json['animal'],
      element: json['element'],
      ghost: json['ghost'],
      commonRoom: json['commonRoom'],
      heads: json['heads']
          .map<HeadModel>((head) => HeadModel.fromJson(head))
          .toList(),
      traits: json['traits']
          .map<TraitModel>((trait) => TraitModel.fromJson(trait))
          .toList(),
    );
  }
}
