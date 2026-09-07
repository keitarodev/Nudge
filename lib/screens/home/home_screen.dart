import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

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
      // App Bar / Header
      // ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,

        titleSpacing: AppSpacing.large,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getDate(),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              'Your nudges',
              style: AppTextStyles.heading,
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppSpacing.large,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                'K',
                style: TextStyle(
                  color: AppColors.dark,
                  fontWeight: FontWeight.bold,
                ),
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
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${nudges.length} Active Nudges',
                          style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 22,
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

                    Container(
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
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.large,
                ),

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
          // Section Header
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
          for (int i = 0; i < nudges.length; i++)
            _buildNudgeCard(
              context,
              nudges[i],
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
    final theme = Theme.of(context);

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
  // Nudge Card
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
          color: theme.colorScheme.outline,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.standard,
        ),
        child: Row(
          children: [

            // ─────────────────────────────────────────
            // Category Icon
            // ─────────────────────────────────────────
            Container(
              width: 48,
              height: 48,
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
                children: [

                  Text(
                    nudge['title']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle,
                  ),

                  const SizedBox(
                    height: AppSpacing.small,
                  ),

                  Text(
                    nudge['category']!,
                    style: theme.textTheme.bodySmall,
                  ),

                  const SizedBox(
                    height: AppSpacing.small,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(
                        width: AppSpacing.small,
                      ),
                      Expanded(
                        child: Text(
                          nudge['place']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.small,
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 16,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(
                        width: AppSpacing.small,
                      ),
                      Text(
                        nudge['trigger']!,
                        style: theme.textTheme.bodySmall,
                      ),

                      const SizedBox(
                        width: AppSpacing.standard,
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

  // ─────────────────────────────────────────────
  // Date
  // ─────────────────────────────────────────────
  String _getDate() {
    final now = DateTime.now();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return '${weekdays[now.weekday - 1]}, '
        '${months[now.month - 1]} ${now.day}';
  }
}