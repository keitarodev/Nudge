import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';
import '../../models/nudge_history.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';

  final List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  DateTime _getDateOnly(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  String _getDateLabel(DateTime date) {
    final today = _getDateOnly(DateTime.now());

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final itemDate = _getDateOnly(date);

    if (itemDate == today) {
      return 'TODAY';
    }

    if (itemDate == yesterday) {
      return 'YESTERDAY';
    }

    return '${_months[itemDate.month - 1]} '
        '${itemDate.day}, '
        '${itemDate.year}';
  }

  String _getTime(DateTime date) {
    int hour = date.hour;

    String period = 'AM';

    if (hour >= 12) {
      period = 'PM';
    }

    if (hour > 12) {
      hour = hour - 12;
    }

    if (hour == 0) {
      hour = 12;
    }

    final minute = date.minute.toString().padLeft(
      2,
      '0',
    );

    return '$hour:$minute $period';
  }

  Nudge? _getNudge(String nudgeId) {
    for (final nudge in AppData.nudges) {
      if (nudge.id == nudgeId) {
        return nudge;
      }
    }

    return null;
  }

  String _getCategoryName(String categoryId) {
    for (final category in AppData.categories) {
      if (category.id == categoryId) {
        return category.name;
      }
    }

    return categoryId;
  }

  String _getPlaceName(String placeId) {
    for (final place in AppData.places) {
      if (place.id == placeId) {
        return place.name;
      }
    }

    return placeId;
  }

  List<NudgeHistory> _getFilteredHistory() {
    final today = _getDateOnly(
      DateTime.now(),
    );

    final history = AppData.history;

    if (_selectedFilter == 'All') {
      return history;
    }

    if (_selectedFilter == 'Today') {
      return history.where((item) {
        return _getDateOnly(item.triggeredAt) == today;
      }).toList();
    }

    if (_selectedFilter == 'This Week') {
      final weekStart = today.subtract(
        Duration(days: today.weekday - 1),
      );

      return history.where((item) {
        final itemDate = _getDateOnly(
          item.triggeredAt,
        );

        return itemDate.isAfter(
              weekStart.subtract(
                const Duration(days: 1),
              ),
            ) &&
            itemDate.isBefore(
              today.add(
                const Duration(days: 1),
              ),
            );
      }).toList();
    }

    if (_selectedFilter == 'This Month') {
      return history.where((item) {
        return item.triggeredAt.year == today.year &&
            item.triggeredAt.month == today.month;
      }).toList();
    }

    return history;
  }

  Map<String, List<NudgeHistory>> _groupHistory(
    List<NudgeHistory> items,
  ) {
    final sortedHistory = List<NudgeHistory>.from(
      items,
    );

    sortedHistory.sort(
      (a, b) => b.triggeredAt.compareTo(
        a.triggeredAt,
      ),
    );

    final Map<String, List<NudgeHistory>> grouped = {};

    for (final item in sortedHistory) {
      final label = _getDateLabel(
        item.triggeredAt,
      );

      if (!grouped.containsKey(label)) {
        grouped[label] = [];
      }

      grouped[label]!.add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colors = theme.colorScheme;

    final filteredHistory = _getFilteredHistory();

    final groupedHistory = _groupHistory(
      filteredHistory,
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: AppSpacing.standard,

        title: Text(
          'History',
          style: AppTextStyles.heading,
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },

            icon: const Icon(
              Icons.tune_rounded,
            ),

            tooltip: 'Filter history',

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppSizes.radiusMedium,
              ),
            ),

            itemBuilder: (context) {
              return [
                _buildFilterMenuItem(
                  context,
                  'All',
                  colors,
                ),
                _buildFilterMenuItem(
                  context,
                  'Today',
                  colors,
                ),
                _buildFilterMenuItem(
                  context,
                  'This Week',
                  colors,
                ),
                _buildFilterMenuItem(
                  context,
                  'This Month',
                  colors,
                ),
              ];
            },
          ),

          const SizedBox(
            width: AppSpacing.small,
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: AppSpacing.normal,
            ),

            if (_selectedFilter != 'All')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.normal,
                      vertical: AppSpacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusSmall,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 16,
                          color: colors.onPrimaryContainer,
                        ),

                        const SizedBox(
                          width: AppSpacing.small,
                        ),

                        Text(
                          _selectedFilter,
                          style: AppTextStyles.smallText.copyWith(
                            color: colors.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            if (_selectedFilter != 'All')
              const SizedBox(
                height: AppSpacing.normal,
              ),

            Expanded(
              child: filteredHistory.isEmpty
                  ? _buildEmptyState(context)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.large,
                        0,
                        AppSpacing.large,
                        AppSpacing.extraLarge,
                      ),
                      children: [
                        for (final group
                            in groupedHistory.entries) ...[
                          _buildSectionHeader(
                            context,
                            group.key,
                            group.value.length,
                          ),

                          const SizedBox(
                            height: AppSpacing.normal,
                          ),

                          for (final item in group.value)
                            _buildHistoryCard(
                              context,
                              item,
                            ),

                          const SizedBox(
                            height: AppSpacing.small,
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildFilterMenuItem(
    BuildContext context,
    String value,
    ColorScheme colors,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          if (_selectedFilter == value)
            Icon(
              Icons.check_rounded,
              size: 18,
              color: colors.primary,
            ),

          if (_selectedFilter != value)
            const SizedBox(
              width: 18,
            ),

          const SizedBox(
            width: AppSpacing.small,
          ),

          Text(
            value,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String label,
    int count,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.sectionHeading.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        Text(
          '$count ${count == 1 ? 'event' : 'events'}',
          style: AppTextStyles.smallText.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    NudgeHistory item,
  ) {
    final theme = Theme.of(context);

    final colors = theme.colorScheme;

    final nudge = _getNudge(
      item.nudgeId,
    );

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.small,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.normal,
        vertical: AppSpacing.normal,
      ),

      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLarge,
        ),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? AppColors.outlineDark.withAlpha(
                  (255 * 0.1).round(),
                )
              : AppColors.outlineLight,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 20,
              color: colors.onPrimaryContainer,
            ),
          ),

          const SizedBox(
            width: AppSpacing.normal,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nudge?.title ?? 'Unknown Nudge',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle,
                ),

                const SizedBox(
                  height: AppSpacing.micro,
                ),

                Text(
                  nudge == null
                      ? 'Unknown Place · Unknown Category'
                      : '${_getPlaceName(nudge.placeId)} · '
                        '${_getCategoryName(nudge.categoryId)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.smallText.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.small,
          ),

          Text(
            _getTime(item.triggeredAt),
            style: AppTextStyles.smallText.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 48,
            color: theme.colorScheme.primary,
          ),

          const SizedBox(
            height: AppSpacing.normal,
          ),

          Text(
            'No history found',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: AppSpacing.small,
          ),

          Text(
            'There are no events for this filter.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}