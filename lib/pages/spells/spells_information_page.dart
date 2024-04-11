import 'package:flutter/material.dart';
import 'package:domain/entities/spell_entities/spell_entity.dart';

class SpellsInformationPage extends StatelessWidget {
  final SpellEntity spell;

  const SpellsInformationPage({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spell.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${spell.type}'),
            Text(
                'Incantation: ${spell.incantation.isEmpty ? 'Unknown' : spell.incantation}'),
            Text('Effect: ${spell.effect}'),
            Text('Can be verbal? ${spell.canBeVerbal ? 'Yes' : 'No'}'),
            Text('Light: ${spell.light}'),
            Text(
                'Creator: ${spell.creator.isEmpty ? 'Unknown' : spell.creator}'),
          ],
        ),
      ),
    );
  }
}
