import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({
    super.key,
    required this.onFinished,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds, then open the main app
    Timer(
      const Duration(seconds: 2),
      widget.onFinished,
    );
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
            // Nudge Logo
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/nudge_logo-03.png'
                    : 'assets/images/nudge_logo-02.png',
                width: 150,
              ),
            ),

            const SizedBox(
              height: AppSpacing.small,
            ),

            Text(
              'Remember when it matters.',
              style: AppTextStyles.cardTitle.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}