import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds, then open the main app
    Timer(const Duration(seconds: 2), widget.onFinished);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ─────────────────────────────────────────────
            // Nudge Logo
            // ─────────────────────────────────────────────
            Image.asset(
              'assets/images/nudge_logo-02.png',
              width: 300,
              height: 100,
              fit: BoxFit.contain,
            ),

            // ─────────────────────────────────────────────
            // App Name
            // ─────────────────────────────────────────────
            // Text('Nudge', style: AppTextStyles.heading),

            const SizedBox(height: AppSpacing.small),

            Text(
              'Remember when it matters.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
