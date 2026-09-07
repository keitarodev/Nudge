import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class TriggerScreen extends StatelessWidget {
  final NudgeTrigger selectedTrigger;
  final ValueChanged<NudgeTrigger> onTriggerChanged;

  const TriggerScreen({
    super.key,
    required this.selectedTrigger,
    required this.onTriggerChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('When should we remind you?', style: textTheme.displayLarge),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Choose what should happen at the selected place.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.extraLarge),

          _buildTriggerOption(
            context: context,
            trigger: NudgeTrigger.arrive,
            icon: Icons.login_rounded,
            title: 'When I arrive',
            description: 'Remind me when I enter the selected area.',
          ),
          const SizedBox(height: AppSpacing.standard),

          _buildTriggerOption(
            context: context,
            trigger: NudgeTrigger.leave,
            icon: Icons.logout_rounded,
            title: 'When I leave',
            description: 'Remind me when I exit the selected area.',
          ),

          const SizedBox(height: AppSpacing.standard),

          _buildTriggerOption(
            context: context,
            trigger: NudgeTrigger.nearby,
            icon: Icons.radar_rounded,
            title: 'When I’m nearby',
            description: 'Remind me when I enter the selected radius.',
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerOption({
    required BuildContext context,
    required NudgeTrigger trigger,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = selectedTrigger == trigger;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          onTriggerChanged(trigger);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(AppSpacing.large),
          backgroundColor: isSelected
              ? colorScheme.primary
              : colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: AppSpacing.standard),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.micro),
                  Text(
                    description,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded),
          ],
        ),
      ),
    );
  }
}
