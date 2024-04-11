import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/pages/houses/cubit/houses_cubit.dart';
import 'package:wizarding_world/pages/houses/cubit/houses_state.dart';
import 'package:wizarding_world/pages/houses/factory/house_factory.dart';
import 'package:wizarding_world/pages/houses/houses_information_page.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HousesCubit>(
      create: (context) => HouseFactory.createCubit()..housesRequested(),
      child: BlocBuilder<HousesCubit, HousesCubitState>(
        builder: (context, state) {
          if (state is HousesStateLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else if (state is HousesStateError) {
            return Center(child: Text(state.message));
          } else if (state is HousesStateLoaded) {
            return ListView.builder(
              itemCount: state.houses.length,
              itemBuilder: (context, index) {
                final house = state.houses[index];
                return ListTile(
                  title: Text(house.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Founder: ${house.founder}'),
                      Text(
                          'Heads: ${house.heads.map((head) => head.firstName).join(', ')}'),
                      Text(
                          'Traits: ${house.traits.map((trait) => trait.name).join(', ')}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HouseInformationPage(house: house),
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
