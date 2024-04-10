import 'package:equatable/equatable.dart';
import 'package:domain/entities/house_entities/head_entity.dart';
import 'package:domain/entities/house_entities/house_entity.dart';
import 'package:domain/entities/house_entities/trait_entity.dart';

class HouseModel extends HouseEntity with EquatableMixin {
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
          .map<HeadEntity>((head) => HeadEntity(
                id: head['id'],
                firstName: head['firstName'],
                lastName: head['lastName'],
              ))
          .toList(),
      traits: json['traits']
          .map<TraitEntity>((trait) => TraitEntity(
                id: trait['id'],
                name: trait['name'],
              ))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id];
}
