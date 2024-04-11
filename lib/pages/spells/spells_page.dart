import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/pages/spells/cubit/spells_cubit.dart';
import 'package:wizarding_world/pages/spells/cubit/spells_state.dart';
import 'package:wizarding_world/pages/spells/factory/spell_factory.dart';
import 'package:wizarding_world/pages/spells/spells_information_page.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpellsCubit>(
      create: (context) => SpellFactory.createCubit()..spellsRequested(),
      child: BlocBuilder<SpellsCubit, SpellsCubitState>(
        builder: (context, state) {
          if (state is SpellsStateLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state is SpellsStateError) {
            return Center(child: Text(state.message));
          } else if (state is SpellsStateLoaded) {
            return ListView.builder(
              itemCount: state.spells.length,
              itemBuilder: (context, index) {
                final spell = state.spells[index];
                return Card(
                  child: ListTile(
                    title: Text(spell.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${spell.type}'),
                        Text('Effect: ${spell.effect}'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SpellsInformationPage(spell: spell),
                        ),
                      );
                    },
                  ),
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
