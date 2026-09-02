import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightAccent,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightAccent,
      surface: AppColors.lightBackground,
      onSurface: AppColors.color1,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading,
      titleLarge: AppTextStyles.sectionHeading,
      bodyLarge: AppTextStyles.body,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkAccent,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkAccent,
      surface: AppColors.darkBackground,
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading,
      titleLarge: AppTextStyles.sectionHeading,
      bodyLarge: AppTextStyles.body,
    ),
  );
}
