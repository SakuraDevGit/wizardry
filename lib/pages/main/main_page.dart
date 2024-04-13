import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wizarding_world/core/services/theme_service.dart';
import 'package:wizarding_world/pages/elixirs/elixirs_page.dart';
import 'package:wizarding_world/pages/elixirs/factory/elixir_factory.dart';
import 'package:wizarding_world/pages/houses/factory/house_factory.dart';
import 'package:wizarding_world/pages/houses/houses_page.dart';
import 'package:wizarding_world/pages/spells/factory/spell_factory.dart';
import 'package:wizarding_world/pages/spells/spells_page.dart';

class MainPageWrapperProvider extends StatelessWidget {
  const MainPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final cubit = SpellFactory.createCubit();
          cubit.spellsRequested();
          return cubit;
        }),
        BlocProvider(create: (context) {
          final cubit = HouseFactory.createCubit();
          cubit.housesRequested();
          return cubit;
        }),
        BlocProvider(create: (context) {
          final cubit = ElixirFactory.createCubit();
          cubit.elixirsRequested();
          return cubit;
        }),
      ],
      child: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Wizarding World',
            style: themeData.textTheme.headlineMedium,
          ),
          centerTitle: true,
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                })
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Houses'),
              Tab(text: 'Spells'),
              Tab(text: 'Elixirs'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HousesPage(),
            SpellsPage(),
            ElixirsPage(),
          ],
        ),
      ),
    );
  }
}
