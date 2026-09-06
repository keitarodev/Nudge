import 'package:flutter/material.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class AppearanceScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const AppearanceScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 96,
        titleSpacing: AppSpacing.large,
        title: Text("Appearance", style: AppTextStyles.heading),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.standard),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
            ),
            child: RadioGroup<ThemeMode>(
              groupValue: themeMode,
              onChanged: (value) {
                onThemeModeChanged(value!);
              },
              child: Column(
                children: [
                  const RadioListTile<ThemeMode>(
                    title: Text("System default"),
                    value: ThemeMode.system,
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.1),
                  ),
                  const RadioListTile<ThemeMode>(
                    title: Text("Light"),
                    value: ThemeMode.light,
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.1),
                  ),
                  const RadioListTile<ThemeMode>(
                    title: Text("Dark"),
                    value: ThemeMode.dark,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
            child: Text(
              "If System default is selected, Nudge will automatically adjust "
              "your appearance based on your device's system settings.",
              style: AppTextStyles.smallText.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
