import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/elixirs/cubit/elixirs_cubit.dart';
import 'package:wizarding_world/2_application/pages/elixirs/cubit/elixirs_state.dart';
import 'package:wizarding_world/2_application/pages/elixirs/elixirs_information_page.dart';

class ElixirsPage extends StatelessWidget {
  const ElixirsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElixirsCubit>(
      create: (context) => ElixirsCubit()..housesRequested(),
      child: BlocBuilder<ElixirsCubit, ElixirsCubitState>(
        builder: (context, state) {
          if (state is ElixirsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ElixirsStateError) {
            return Center(child: Text(state.message));
          } else if (state is ElixirsStateLoaded) {
            return ListView.builder(
              itemCount: state.elixirs.length,
              itemBuilder: (context, index) {
                final elixir = state.elixirs[index];
                return ListTile(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ElixirInformationPage(elixir: elixir),
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