import 'package:flutter/material.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';

class ElixirInformationPage extends StatelessWidget {
  final ElixirEntity elixir;

  const ElixirInformationPage({super.key, required this.elixir});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elixir.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Effect: ${elixir.effect.isEmpty ? 'Unknown' : elixir.effect}'),
            Text(
                'Side Effects: ${elixir.sideEffects.isEmpty ? 'Unknown' : elixir.sideEffects}'),
            Text(
                'Characteristics: ${elixir.characteristics.isEmpty ? 'Unknown' : elixir.characteristics}'),
            Text('Time: ${elixir.time.isEmpty ? 'Unknown' : elixir.time}'),
            Text(
                'Difficulty: ${elixir.difficulty.isEmpty ? 'Unknown' : elixir.difficulty}'),
            Text(
                'Ingredients: ${elixir.ingredients.map((ingredient) => ingredient.name).join(', ')}'),
            Text(
                'Inventors: ${elixir.inventors.map((inventor) => inventor.firstName).join(', ')}'),
            Text(
                'Manufacturer: ${elixir.manufacturer.isEmpty ? 'Unknown' : elixir.manufacturer}'),
          ],
        ),
      ),
    );
  }
}
