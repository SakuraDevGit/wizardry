import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wizarding_world/2_application/core/services/theme_service.dart';
import 'package:wizarding_world/2_application/pages/houses/houses_page.dart';
import 'package:wizarding_world/2_application/pages/main/cubit/main_cubit.dart';
import 'package:wizarding_world/2_application/pages/spells/spells_page.dart';

class MainPageWrapperProvider extends StatelessWidget {
  const MainPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
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
      length: 3, // Number of tabs
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
            // Content for Tab 1
            HousesPage(),
            // Content for Tab 2
            SpellsPage(),
            // Content for Tab 3
            Center(child: Text('Tab 3 Content')),
          ],
        ),
      ),
    );
  }
}
