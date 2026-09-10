import 'package:flutter/material.dart';

import '../../models/nudge.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class ReviewNudgeScreen extends StatelessWidget {
  final Nudge nudge;

  const ReviewNudgeScreen({super.key, required this.nudge});

  String _radiusLabel(double radius) {
    if (radius == 1000) {
      return '1 kilometre';
    }

    return '${radius.toInt()} metres';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review your Nudge', style: textTheme.displayLarge),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Check the details before saving.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.extraLarge),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.large),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                _buildReviewRow(
                  context: context,
                  icon: Icons.notifications_none_rounded,
                  label: 'Reminder',
                  value: nudge.title,
                ),
                const Divider(height: AppSpacing.extraLarge),

                _buildReviewRow(
                  context: context,
                  icon: Icons.category_outlined,
                  label: 'Category',
                  value: nudge.categoryId,
                ),
                const Divider(height: AppSpacing.extraLarge),

                _buildReviewRow(
                  context: context,
                  icon: Icons.sync_alt_rounded,
                  label: 'Trigger',
                  value: nudge.trigger.label,
                ),
                const Divider(height: AppSpacing.extraLarge),

                _buildReviewRow(
                  context: context,
                  icon: Icons.location_on_outlined,
                  label: 'Place',
                  value: nudge.placeId,
                ),
                const Divider(height: AppSpacing.extraLarge),

                _buildReviewRow(
                  context: context,
                  icon: Icons.radar_rounded,
                  label: 'Radius',
                  value: _radiusLabel(nudge.radius.toDouble()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: AppSpacing.standard),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.micro),
              Text(value, style: textTheme.titleLarge),
            ],
          ),
        ),
      ],
    );
  }
}
