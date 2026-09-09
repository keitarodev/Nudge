import 'package:flutter/material.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'appearance_screen.dart';
import 'categories_screen.dart';
import 'about_nudge_screen.dart';
import '../../theme/app_colors.dart';
import 'saved_location_screen.dart';

class SettingsScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.standard,
        title: Text("Settings", style: AppTextStyles.heading),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.standard),
        children: [
          Text(
            "Preferences",
            style: AppTextStyles.sectionHeading.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                    : AppColors.outlineLight,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.brightness_6_outlined,
                    size: AppSizes.icon,
                  ),
                  title: Text("Appearance"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppearanceScreen(
                          themeMode: widget.themeMode,
                          onThemeModeChanged: widget.onThemeModeChanged,
                        ),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                      : AppColors.outlineLight,
                ),
                ListTile(
                  leading: Icon(
                    Icons.notifications_outlined,
                    size: AppSizes.icon,
                  ),
                  title: Text("Notifications"),
                  trailing: Switch(
                    value: notificationsEnabled,
                    inactiveThumbColor: AppColors.outlineLight,
                    inactiveTrackColor: Theme.of(context).colorScheme.surface,
                    trackOutlineColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Theme.of(context).colorScheme.primary;
                      }
                      return Theme.of(context).brightness == Brightness.dark
                          ? AppColors.outlineDark.withAlpha((255 * 0.2).round())
                          : AppColors.outlineLight;
                    }),
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Text(
            "Personalization",
            style: AppTextStyles.sectionHeading.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                    : AppColors.outlineLight,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.category_outlined, size: AppSizes.icon),
                  title: Text("Categories"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesScreen(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                      : AppColors.outlineLight,
                ),

                ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    size: AppSizes.icon,
                  ),
                  title: Text("Saved Location"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedLocationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Text(
            "About",
            style: AppTextStyles.sectionHeading.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.standard),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                    : AppColors.outlineLight,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info_outline, size: AppSizes.icon),
                  title: Text("About Nudge"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutNudgeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
