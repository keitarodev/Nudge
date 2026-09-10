import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class NudgeSavedScreen extends StatelessWidget {
  final Nudge nudge;
  final VoidCallback onCreateAnother;

  const NudgeSavedScreen({
    super.key,
    required this.nudge,
    required this.onCreateAnother,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 52,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.extraLarge),

            Text(
              'Nudge saved!',
              textAlign: TextAlign.center,
              style: textTheme.displayLarge,
            ),
            const SizedBox(height: AppSpacing.small),

            Text(
              '"${nudge.title}" is ready to remind you '
              '${nudge.trigger.label.toLowerCase()} at '
              '${nudge.placeId}.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.extraLarge),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCreateAnother,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Create another Nudge'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.standard,
                  ),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
