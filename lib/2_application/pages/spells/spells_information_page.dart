// this widget should take in a SpellEntity and display the name, type, incantation, effect, canBeVerbal, and creator of the spell.
// It will not use any cubit or bloc, but will be a simple StatelessWidget that takes in a SpellEntity and displays the information.
// There must be no scaffold as we will navigate to this page from the existing spells page when the user clicks on a spell.

import 'package:flutter/material.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';

class SpellsInformationPage extends StatelessWidget {
  final SpellEntity spell;

  const SpellsInformationPage({Key? key, required this.spell})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: ${spell.name}'),
        Text('Type: ${spell.type}'),
        Text('Incantation: ${spell.incantation}'),
        Text('Effect: ${spell.effect}'),
        Text('Can be verbal? ${spell.canBeVerbal ? 'Yes' : 'No'}'),
        Text('Creator: ${spell.creator.isEmpty ? 'Unknown' : spell.creator}'),
      ],
    );
  }
}
