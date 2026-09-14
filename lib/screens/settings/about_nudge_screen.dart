import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class AboutNudgeScreen extends StatelessWidget {
  const AboutNudgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final logoAsset = isDarkMode
        ? "assets/images/nudge_logo-03.png"
        : "assets/images/nudge_logo-02.png";

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.standard,
        title: Text("About Nudge", style: AppTextStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logoAsset, width: 200, height: 60, fit: BoxFit.contain),
            const SizedBox(height: AppSpacing.small),
            Text(
              "A location-based reminder app that reminds you about things when you arrive at the right place.",
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),

            const SizedBox(height: AppSpacing.large),

            Text("Developed by", style: AppTextStyles.sectionHeading),

            const SizedBox(height: AppSpacing.small),

            Text(
              "Chui Vanenteakbot\n"
              "Top Keitaro\n"
              "Lao David\n"
              "Sorn Kunwath\n"
              "Keo Ratanak",
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),

            const SizedBox(height: AppSpacing.large),
            Text(
              "Version 1.0.0",
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
