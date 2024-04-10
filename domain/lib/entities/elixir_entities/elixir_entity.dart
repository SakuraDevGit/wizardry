import 'package:domain/entities/elixir_entities/ingredient_entity.dart';
import 'package:domain/entities/elixir_entities/inventor_entity.dart';

class ElixirEntity {
  final String id;
  final String name;
  final String effect;
  final String sideEffects;
  final String characteristics;
  final String time;
  final String difficulty;
  final List<IngredientEntity> ingredients;
  final List<InventorEntity> inventors;
  final String manufacturer;

  ElixirEntity({
    required this.id,
    required this.name,
    required this.effect,
    required this.sideEffects,
    required this.characteristics,
    required this.time,
    required this.difficulty,
    required this.ingredients,
    required this.inventors,
    required this.manufacturer,
  });
}
