import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';
import 'screens/places/places_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'widgets/app_buttom_nav.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const PlacesScreen(),
      const Center(child: Text("Create Nudge")),
      const HistoryScreen(),
      SettingsScreen(
        themeMode: themeMode,
        onThemeModeChanged: (mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nudge",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: AppBottomNav(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
