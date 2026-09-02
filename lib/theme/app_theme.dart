import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightAccent,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading,
      titleLarge: AppTextStyles.sectionHeading,
      bodyLarge: AppTextStyles.body,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkAccent,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading,
      titleLarge: AppTextStyles.sectionHeading,
      bodyLarge: AppTextStyles.body,
    ),
  );
}
