import 'package:flutter/material.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'appearance_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool locationEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings", style: AppTextStyles.heading)),
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
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
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
                        builder: (context) => const AppearanceScreen(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
                ListTile(
                  leading: Icon(
                    Icons.notifications_outlined,
                    size: AppSizes.icon,
                  ),
                  title: Text("Notifications"),
                  trailing: Switch(
                    value: notificationsEnabled,
                    inactiveThumbColor: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.20),
                    inactiveTrackColor: Theme.of(context).colorScheme.surface,
                    trackOutlineColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Theme.of(context).colorScheme.primary;
                      }
                      return Theme.of(
                        context,
                      ).dividerColor.withValues(alpha: 0.3);
                    }),
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    size: AppSizes.icon,
                  ),
                  title: Text("Location"),
                  trailing: Switch(
                    value: locationEnabled,
                    inactiveThumbColor: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.20),
                    inactiveTrackColor: Theme.of(context).colorScheme.surface,
                    trackOutlineColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Theme.of(context).colorScheme.primary;
                      }
                      return Theme.of(
                        context,
                      ).dividerColor.withValues(alpha: 0.3);
                    }),
                    onChanged: (value) {
                      setState(() {
                        locationEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
