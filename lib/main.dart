import 'package:data/hive/hive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizarding_world/core/services/theme_service.dart';
import 'package:wizarding_world/pages/main/main_page.dart';
import 'package:wizarding_world/theme.dart';

void main() async {
  await HiveWrapper.initFlutter();
  HiveWrapper.registerWrappers();

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const MainPageWrapperProvider(),
      );
    });
  }
}
