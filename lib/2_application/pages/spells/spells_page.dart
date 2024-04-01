import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_cubit.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_state.dart';
import 'package:wizarding_world/2_application/pages/spells/spells_information_page.dart';

// The spells page is a StatelessWidget that uses the SpellsCubit to manage the state of the page.
// The SpellsCubit is responsible for fetching the spells data from the repository and updating the state of the page.
// The spells page must be wrapped in a BlocProvider that is generic over SpellsCubit to provide the SpellsCubit to the page.
// The spells page uses the BlocBuilder widget to rebuild the page whenever the state of the SpellsCubit changes.
// The spalls page must be able to flip its UI with an animation, on the one side, it must allow the user to specify
// the name of the spell, the type of the spell (which is a hardcoded list of strings that include None, Charm, Conjuration, etc),
// along with the incantation for the spell.
// The user will then press a button, and this button will call spellRequested and give the name of the spell, the type of the spell, and the incantation
// to the function.
// The other side of the UI will show a list of spells that are fetched from the GetSpellsUseCase.

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
