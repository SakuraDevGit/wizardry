import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_cubit.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_state.dart';
import 'package:wizarding_world/2_application/pages/spells/spells_information_page.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpellsCubit>(
      create: (context) => SpellsCubit()..spellsRequested(),
      child: BlocBuilder<SpellsCubit, SpellsCubitState>(
        builder: (context, state) {
          if (state is SpellsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpellsStateError) {
            return Center(child: Text(state.message));
          } else if (state is SpellsStateLoaded) {
            return ListView.builder(
              itemCount: state.spells.length,
              itemBuilder: (context, index) {
                final spell = state.spells[index];
                return ListTile(
                  title: Text(spell.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type: ${spell.type}'),
                      Text('Incantation: ${spell.incantation}'),
                      Text('Effect: ${spell.effect}'),
                      Text(
                          'Can be verbal? ${spell.canBeVerbal ? 'Yes' : 'No'}'),
                      Text('Type: ${spell.type}'),
                      Text(
                          'Creator: ${spell.creator.isEmpty ? 'Unknown' : spell.creator}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpellsInformationPage(spell: spell),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
