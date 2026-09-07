import 'package:flutter/material.dart';

class AppColors {
  // ─────────────────────────────────────────────
  // Base Palette
  // ─────────────────────────────────────────────

  static const Color dark = Color(0xFF0E151A);
  static const Color darkSecondary = Color(0xFF243540);
  static const Color blueDark = Color(0xFF486B80);
  static const Color blue = Color(0xFF73AACC);
  static const Color accent = Color(0xFF90D5FF);
  static const Color blueLight = Color(0xFFA6DDFF);
  static const Color blueVeryLight = Color(0xFFC7EAFF);
  static const Color lightSurface = Color(0xFFE3F5FF);
  static const Color light = Color(0xFFF4FBFF);

  // ─────────────────────────────────────────────
  // Light Mode
  // ─────────────────────────────────────────────

  static const Color lightBackground = light;
  static const Color lightText = dark;
  static const Color lightAccent = accent;

  // ─────────────────────────────────────────────
  // Dark Mode
  // ─────────────────────────────────────────────

  static const Color darkBackground = dark;
  static const Color darkText = light;
  static const Color darkAccent = accent;

  // ─────────────────────────────────────────────
  // Supporting Colors
  // ─────────────────────────────────────────────

  static const Color lightSecondary = darkSecondary;
  static const Color darkSecondaryText = blueLight;

  static const Color border = blueLight;
}