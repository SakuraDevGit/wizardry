// I want a dart widget that will show a vertical scrollable list of houses.
//Each house should have a name, founder, heads, and traits.
//The list should be populated by the GetHousesUseCase.
//The widget should show a loading spinner while the houses are being fetched,
//an error message if the houses cannot be fetched, and the list of houses if they are fetched successfully.
//The widget should be called HousesPage.
// The mechanism for fetching the houses should be calling the HousesCubit.housesRequested() method.
// The error message and failures described above should be displayed when the Cubit emits a HousesStateError
// The spinner should load when the Cubit emits a HousesStateLoading
// The list of houses should be displayed when the Cubit emits a HousesStateLoaded

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_cubit.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_state.dart';
import 'package:wizarding_world/2_application/pages/houses/houses_information_page.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HousesCubit>(
      create: (context) => HousesCubit()..housesRequested(),
      child: BlocBuilder<HousesCubit, HousesCubitState>(
        builder: (context, state) {
          if (state is HousesStateLoading) {
            return const Center(child: CircularProgressIndicator());
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
