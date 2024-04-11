import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/pages/elixirs/cubit/elixirs_cubit.dart';
import 'package:wizarding_world/pages/elixirs/cubit/elixirs_state.dart';
import 'package:wizarding_world/pages/elixirs/elixirs_information_page.dart';
import 'package:wizarding_world/pages/elixirs/factory/elixir_factory.dart';

class ElixirsPage extends StatelessWidget {
  const ElixirsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElixirsCubit>(
      create: (context) => ElixirFactory.createCubit()..elixirsRequested(),
      child: BlocBuilder<ElixirsCubit, ElixirsCubitState>(
        builder: (context, state) {
          if (state is ElixirsStateLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state is ElixirsStateError) {
            return Center(child: Text(state.message));
          } else if (state is ElixirsStateLoaded) {
            return ListView.builder(
              itemCount: state.elixirs.length,
              itemBuilder: (context, index) {
                final elixir = state.elixirs[index];
                return Card(
                  child: ListTile(
                    title: Text(elixir.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Effect: ${elixir.effect.isEmpty ? 'Unknown' : elixir.effect}'),
                        Text(
                            'Ingredients: ${elixir.ingredients.map((ingredient) => ingredient.name).join(', ')}'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ElixirInformationPage(elixir: elixir),
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
