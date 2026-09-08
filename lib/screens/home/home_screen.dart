import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

import '../history/history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Temporary data for UI testing
  final List<Map<String, String>> nudges = const [
    {
      'title': 'Buy chicken',
      'category': 'Food',
      'place': 'Market',
      'trigger': 'When I arrive',
      'radius': '200 m',
    },
    {
      'title': 'Submit document',
      'category': 'Study',
      'place': 'University',
      'trigger': 'When I arrive',
      'radius': '300 m',
    },
    {
      'title': 'Go to work',
      'category': 'Work',
      'place': 'Office',
      'trigger': 'When I leave',
      'radius': '150 m',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ─────────────────────────────────────────────
      // Header
      // ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: AppSpacing.large,

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

              const SizedBox(
                width: AppSpacing.small,
              ),

              Text(
                'nudge',
                style: AppTextStyles.heading,
              ),
            ],
          ),
        ),

        // ─────────────────────────────────────────────
        // Header Actions
        // ─────────────────────────────────────────────
        actions: [
          // History
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.history_outlined,
            ),
          ),

          // Notifications
          Padding(
            padding: const EdgeInsets.only(
              right: AppSpacing.large,
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Open notifications
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
              ),
            ),
          ),
        ],
      ),

      // ─────────────────────────────────────────────
      // Body
      // ─────────────────────────────────────────────
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.normal,
          AppSpacing.large,
          AppSpacing.large,
        ),
        children: [
          // ─────────────────────────────────────────────
          // Active Nudge Summary
          // ─────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(
              AppSpacing.large,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(
                AppSizes.radiusLarge,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active Nudge Text
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${nudges.length} Active Nudges',
                          style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(
                          height: AppSpacing.small,
                        ),

                        Text(
                          'Your location reminders are active',
                          style: TextStyle(
                            color: AppColors.dark.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    // Notification Icon
                    Transform.translate(
                      offset: const Offset(0, 1),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.dark.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_active,
                          color: AppColors.dark,
                          size: AppSizes.icon,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.large,
                ),

                // Arrive / Leave Summary
                Row(
                  children: [
                    _buildSummaryItem(
                      context,
                      Icons.login,
                      '2 arrive',
                    ),

                    const SizedBox(
                      width: AppSpacing.small,
                    ),

                    _buildSummaryItem(
                      context,
                      Icons.logout,
                      '1 leave',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSpacing.large,
          ),

          // ─────────────────────────────────────────────
          // TODAY
          // ─────────────────────────────────────────────
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Text(
                'TODAY',
                style: AppTextStyles.sectionHeading,
              ),

              TextButton(
                onPressed: () {
                  // TODO: Open all nudges
                },
                child: const Text('See all'),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.standard,
          ),

          // ─────────────────────────────────────────────
          // Nudge List
          // ─────────────────────────────────────────────
          for (final nudge in nudges)
            _buildNudgeCard(
              context,
              nudge,
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Summary Item
  // ─────────────────────────────────────────────
  Widget _buildSummaryItem(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.standard,
        vertical: AppSpacing.small,
      ),
      decoration: BoxDecoration(
        color: AppColors.dark.withOpacity(0.12),
        borderRadius: BorderRadius.circular(
          AppSizes.radiusMedium,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.dark,
          ),

          const SizedBox(
            width: AppSpacing.small,
          ),

          Text(
            text,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Compact Nudge Card
  // ─────────────────────────────────────────────
  Widget _buildNudgeCard(
    BuildContext context,
    Map<String, String> nudge,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.standard,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLarge,
        ),
        side: BorderSide(
          color: Color(0xFFE0E0E0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.standard,
          vertical: AppSpacing.small,
        ),
        child: Row(
          children: [
            // ─────────────────────────────────────────
            // Category Icon
            // ─────────────────────────────────────────
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(
                  AppSizes.radiusMedium,
                ),
              ),
              child: Icon(
                _getCategoryIcon(
                  nudge['category']!,
                ),
                color: theme.colorScheme.onPrimaryContainer,
                size: AppSizes.icon,
              ),
            ),

            const SizedBox(
              width: AppSpacing.standard,
            ),

            // ─────────────────────────────────────────
            // Nudge Information
            // ─────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    nudge['title']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle,
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  // Location + Trigger + Radius
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: theme.colorScheme.secondary,
                      ),

                      const SizedBox(
                        width: 4,
                      ),

                      Flexible(
                        child: Text(
                          nudge['place']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Icon(
                        Icons.notifications_outlined,
                        size: 17,
                        color: theme.colorScheme.secondary,
                      ),

                      const SizedBox(
                        width: 4,
                      ),

                      Flexible(
                        child: Text(
                          nudge['trigger']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Text(
                        nudge['radius']!,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSpacing.small,
            ),

            // ─────────────────────────────────────────
            // Arrow
            // ─────────────────────────────────────────
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Category Icon
  // ─────────────────────────────────────────────
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Health':
        return Icons.health_and_safety_outlined;

      case 'Study':
        return Icons.school_outlined;

      case 'Shopping':
        return Icons.shopping_bag_outlined;

      case 'Work':
        return Icons.work_outline;

      case 'Home':
        return Icons.home_outlined;

      default:
        return Icons.more_horiz;
    }
  }
}