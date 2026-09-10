import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/new_nudge/new_nudge_screen.dart';

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
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getString('themeMode');

    if (savedTheme == null) {
      return;
    }

    setState(() {
      if (savedTheme == 'light') {
        themeMode = ThemeMode.light;
      } else if (savedTheme == 'dark') {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;
      }
    });
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeMode', mode.name);
  }

  bool showSplash = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const NewNudgeScreen(),
      SettingsScreen(
        themeMode: themeMode,
        onThemeModeChanged: (mode) {
          setState(() {
            themeMode = mode;
          });

          _saveThemeMode(mode);
        },
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nudge',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      home: showSplash
          ? SplashScreen(
              onFinished: () {
                setState(() {
                  showSplash = false;
                });
              },
            )
          : Scaffold(
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
