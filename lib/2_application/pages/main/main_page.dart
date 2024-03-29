import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wizarding_world/2_application/core/services/theme_service.dart';
import 'package:wizarding_world/2_application/pages/main/cubit/main_cubit.dart';
import 'package:wizarding_world/2_application/pages/main/cubit/main_state.dart';

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
    return Scaffold(
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
        ),
        body: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<MainCubit>().adviceRequested();
                  },
                  child: const Text('Get Advice'),
                ),
                BlocBuilder<MainCubit, WizardryCubitState>(
                  builder: (context, state) {
                    if (state is WizardryStateLoading) {
                      return CircularProgressIndicator();
                    } else if (state is WizardryStateLoaded) {
                      return Text(
                        "state.advice",
                        style: themeData.textTheme.headlineMedium,
                      );
                    } else if (state is WizardryStateError) {
                      return Text(
                        state.message,
                        style: themeData.textTheme.headlineMedium,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
