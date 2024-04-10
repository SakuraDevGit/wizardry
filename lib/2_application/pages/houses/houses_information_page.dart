import 'package:flutter/material.dart';
import 'package:domain/entities/house_entities/house_entity.dart';

class HouseInformationPage extends StatelessWidget {
  final HouseEntity house;
  const HouseInformationPage({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(house.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Founder: ${house.founder}'),
            Text('House Colors: ${house.houseColours}'),
            Text(
                'Heads: ${house.heads.map((head) => head.firstName).join(', ')}'),
            Text(
                'Traits: ${house.traits.map((trait) => trait.name).join(', ')}'),
            Text('Animal: ${house.animal}'),
            Text('Element: ${house.element}'),
            Text('Ghost: ${house.ghost}'),
            Text('Common Room: ${house.commonRoom}')
          ],
        ),
      ),
    );
  }
}
