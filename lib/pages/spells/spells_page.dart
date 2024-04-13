import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/pages/spells/cubit/spells_cubit.dart';
import 'package:wizarding_world/pages/spells/cubit/spells_state.dart';
import 'package:wizarding_world/pages/spells/factory/spell_factory.dart';
import 'package:wizarding_world/pages/spells/spells_information_page.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key});

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  Timer? _debounce;
  final _spellsCubit = SpellFactory.createCubit();

  var _searchName = '';
  var _searchType = '';
  var _searchIncantation = '';

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onNameChanged(String query) {
    _searchName = query;
  }

  void _onTypeChanged(String query) {
    _searchType = query;
  }

  void _onIncantationChanged(String query) {
    _searchIncantation = query;
  }

  void _search() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _spellsCubit.spellsRequestedWith(
          name: _searchName,
          type: _searchType,
          incantation: _searchIncantation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpellsCubit>(
      create: (context) => _spellsCubit..spellsRequested(),
      child: BlocBuilder<SpellsCubit, SpellsCubitState>(
        builder: (context, state) {
          if (state is SpellsStateLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state is SpellsStateError) {
            return Center(child: Text(state.message));
          } else if (state is SpellsStateLoaded) {
            return Column(
              children: [
                // name, type
                Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _spellsCubit.spellsRequested();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                          child: const Text('Show All'),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Name of Spell',
                              ),
                              onChanged: _onNameChanged,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Type of Spell',
                              ),
                              onChanged: _onTypeChanged,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Incantation of Spell',
                              ),
                              onChanged: _onIncantationChanged,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _search,
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                          child: const Text('Search'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
