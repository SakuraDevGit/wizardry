import 'package:domain/entities/elixir_entities/elixir_entity.dart';
import 'package:domain/entities/elixir_entities/ingredient_entity.dart';
import 'package:domain/entities/elixir_entities/inventor_entity.dart';

class ElixirModel extends ElixirEntity {
  ElixirModel({
    required super.id,
    required super.name,
    required super.effect,
    required super.sideEffects,
    required super.characteristics,
    required super.time,
    required super.difficulty,
    required super.ingredients,
    required super.inventors,
    required super.manufacturer,
  });

  factory ElixirModel.fromJson(Map<String, dynamic> json) {
    return ElixirModel(
      id: json['id'] as String? ?? 'invalid_id',
      name: json['name'] as String? ?? '',
      effect: json['effect'] as String? ?? '',
      sideEffects: json['sideEffects'] as String? ?? '',
      characteristics: json['characteristics'] as String? ?? '',
      time: json['time'] as String? ?? '',
      difficulty: json['difficulty'] as String? ?? '',
      ingredients: json['ingredients']
          .map<IngredientEntity>((ingredient) => IngredientEntity(
                id: ingredient['id'] as String? ?? 'invalid_id',
                name: ingredient['name'] as String? ?? '',
              ))
          .toList(),
      inventors: json['inventors']
          .map<InventorEntity>((inventor) => InventorEntity(
                id: inventor['id'] as String? ?? 'invalid_id',
                firstName: inventor['firstName'] as String? ?? '',
                lastName: inventor['lastName'] as String? ?? '',
              ))
          .toList(),
      manufacturer: json['manufacturer'] as String? ?? '',
    );
  }
}
