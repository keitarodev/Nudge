import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';
import '../../services/nudge_trigger_service.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class TriggerTestScreen extends StatefulWidget {
  const TriggerTestScreen({super.key});

  @override
  State<TriggerTestScreen> createState() => _TriggerTestScreenState();
}

class _TriggerTestScreenState extends State<TriggerTestScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final activeNudges = AppData.nudges
        .where((nudge) => nudge.status == 'active')
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Test Triggers')),
      body: activeNudges.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.large),
              itemCount: activeNudges.length,
              itemBuilder: (context, index) {
                return _buildNudgeCard(context, activeNudges[index]);
              },
            ),
    );
  }

  Widget _buildNudgeCard(BuildContext context, Nudge nudge) {
    final theme = Theme.of(context);
    final placeName = _getPlaceName(nudge.placeId);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.standard),
      elevation: 0,
      color: theme.brightness == Brightness.light
          ? theme.colorScheme.surface
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nudge.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.cardTitle,
            ),
            const SizedBox(height: AppSpacing.small),
            Text(placeName, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.small),
            Text(
              '${nudge.trigger.label} · ${nudge.radius} m',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.standard),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  NudgeTriggerService.triggerNudge(nudge);

                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(_getButtonText(nudge.trigger)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.normal),
            Text('No active nudges', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.small),
            Text(
              'All active nudges have been triggered.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _getPlaceName(String placeId) {
    for (final place in AppData.places) {
      if (place.id == placeId) {
        return place.name;
      }
    }

    return 'Unknown place';
  }

  String _getButtonText(NudgeTrigger trigger) {
    switch (trigger) {
      case NudgeTrigger.arrive:
        return 'Simulate Arrival';
      case NudgeTrigger.leave:
        return 'Simulate Leaving';
      case NudgeTrigger.nearby:
        return 'Simulate Nearby';
    }
  }
}
