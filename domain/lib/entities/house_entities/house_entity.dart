import 'package:domain/entities/house_entities/head_entity.dart';
import 'package:domain/entities/house_entities/trait_entity.dart';

class HouseEntity {
  final String id;
  final String name;
  final String houseColours;
  final String founder;
  final String animal;
  final String element;
  final String ghost;
  final String commonRoom;
  final List<HeadEntity> heads;
  final List<TraitEntity> traits;

  HouseEntity({
    required this.id,
    required this.name,
    required this.houseColours,
    required this.founder,
    required this.animal,
    required this.element,
    required this.ghost,
    required this.commonRoom,
    required this.heads,
    required this.traits,
  });
}
