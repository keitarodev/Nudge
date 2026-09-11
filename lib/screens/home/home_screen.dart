import 'package:flutter/material.dart';
import 'package:nudge/screens/notifications/notifications_screen.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

import '../history/history_screen.dart';
import 'edit_nudge_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Edit Nudge
  Future<void> editNudge(Nudge nudge) async {
    final updatedNudge = await showModalBottomSheet<Nudge>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EditNudgeBottomSheet(
          nudge: nudge,
          categories: AppData.categories,
          places: AppData.places,
        );
      },
    );

    // Update Home after saving
    if (updatedNudge != null) {
      setState(() {
        final index = AppData.nudges.indexWhere(
          (item) => item.id == updatedNudge.id,
        );

        if (index != -1) {
          AppData.nudges[index] = updatedNudge;
        }
      });
    }
  }

  // Complete Nudge
  void completeNudge(Nudge nudge) {
    setState(() {
      AppData.nudges.removeWhere((item) => item.id == nudge.id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nudge completed')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Trigger counts
    final arriveCount = AppData.nudges
        .where((nudge) => nudge.trigger == NudgeTrigger.arrive)
        .length;

    final leaveCount = AppData.nudges
        .where((nudge) => nudge.trigger == NudgeTrigger.leave)
        .length;

    final nearbyCount = AppData.nudges
        .where((nudge) => nudge.trigger == NudgeTrigger.nearby)
        .length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // Header
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.large,

        // Logo + name
        title: Transform.translate(
          offset: const Offset(0, -2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/nudge_logo-01.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),

              const SizedBox(width: AppSpacing.small),

              Text('nudge', style: AppTextStyles.heading),
            ],
          ),
        ),

        // Header buttons
        actions: [
          // History
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
            icon: const Icon(Icons.history_outlined),
          ),

          // Notification
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.large),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_none_outlined),
                ),

                // Notification red dot
                if (true)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      // Main content
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.normal,
          AppSpacing.large,
          AppSpacing.large,
        ),
        children: [
          // Active nudges summary
          Container(
            padding: const EdgeInsets.all(AppSpacing.large),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total nudges
                Text(
                  '${AppData.nudges.length} Active Nudges',
                  style: const TextStyle(
                    color: AppColors.dark,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: AppSpacing.small),

                // Description
                Text(
                  'Your location reminders are active',
                  style: TextStyle(
                    color: AppColors.dark.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: AppSpacing.large),

                // Trigger statistics
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Arrive
                    _buildSummaryStat(
                      value: arriveCount.toString(),
                      label: 'ARRIVE',
                    ),

                    // Divider
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.dark.withValues(alpha: 0.18),
                    ),

                    // Leave
                    _buildSummaryStat(
                      value: leaveCount.toString(),
                      label: 'LEAVE',
                    ),

                    // Divider
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.dark.withValues(alpha: 0.18),
                    ),

                    // Nearby
                    _buildSummaryStat(
                      value: nearbyCount.toString(),
                      label: 'NEARBY',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.large),

          // Today header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('TODAY', style: AppTextStyles.sectionHeading),

              TextButton(
                onPressed: () {
                  // TODO: Open all nudges
                },
                child: const Text('See all'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.standard),

          // Nudge list
          for (final nudge in AppData.nudges) _buildNudgeCard(context, nudge),
        ],
      ),
    );
  }

  // Summary stat
  Widget _buildSummaryStat({required String value, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Number
        Text(
          value,
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(width: 8),

        // Label
        Text(
          label,
          style: TextStyle(
            color: AppColors.dark.withValues(alpha: 0.65),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  // Nudge card
  Widget _buildNudgeCard(BuildContext context, Nudge nudge) {
    final theme = Theme.of(context);

    // Find related category
    final category = AppData.categories.firstWhere(
      (item) => item.id == nudge.categoryId,
    );

    // Find related place
    final place = AppData.places.firstWhere((item) => item.id == nudge.placeId);

    return Dismissible(
      // Unique key
      key: Key(nudge.id),

      // Only swipe from right to left
      direction: DismissDirection.endToStart,

      // Background shown while swiping
      background: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.standard),
        padding: const EdgeInsets.only(right: AppSpacing.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.check),

            SizedBox(width: AppSpacing.small),

            Text('Complete'),
          ],
        ),
      ),

      // Complete Nudge
      onDismissed: (direction) {
        completeNudge(nudge);
      },

      // Nudge card
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.standard),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          onTap: () {
            editNudge(nudge);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.standard,
              vertical: AppSpacing.standard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + category
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        nudge.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle,
                      ),
                    ),

                    const SizedBox(width: AppSpacing.small),

                    Text(
                      category.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.small),

                // Place + trigger + radius
                Text(
                  '${place.name} · '
                  '${nudge.trigger.label} · '
                  '${nudge.radius} m',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
