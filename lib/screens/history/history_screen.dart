import 'package:flutter/material.dart';

import '../../models/history_item.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _showTriggeredOnly = true;

  // Temporary test data.
  // Replace this with repository/database data later.
  final List<HistoryItem> _history = [
    HistoryItem(
      title: 'Buy chicken',
      location: 'Market',
      category: 'Food',
      date: DateTime(2026, 9, 6, 12, 42),
    ),
    HistoryItem(
      title: 'Buy shampoo',
      location: 'Supermarket',
      category: 'Shopping',
      date: DateTime(2026, 9, 6, 10, 15),
    ),
    HistoryItem(
      title: 'Submit document',
      location: 'University',
      category: 'Study',
      date: DateTime(2026, 9, 5, 16, 20),
    ),
    HistoryItem(
      title: 'Gym session',
      location: 'FitZone',
      category: 'Health',
      date: DateTime(2026, 8, 30, 7, 30),
    ),
    HistoryItem(
      title: 'Coffee with Dara',
      location: 'Brown Coffee',
      category: 'Personal',
      date: DateTime(2026, 8, 28, 11, 30),
    ),
    HistoryItem(
      title: 'Finish assignment',
      location: 'Home',
      category: 'Study',
      date: DateTime(2026, 8, 20, 20, 15),
    ),
    HistoryItem(
      title: 'Go to work',
      location: 'Office',
      category: 'Work',
      date: DateTime(2026, 8, 18, 8, 10),
    ),
    HistoryItem(
      title: 'Buy new shirt',
      location: 'Mall',
      category: 'Shopping',
      date: DateTime(2026, 8, 8, 15, 20),
    ),
    HistoryItem(
      title: 'Call Mom',
      location: 'Home',
      category: 'Personal',
      date: DateTime(2026, 8, 5, 19, 0),
    ),
  ];

  static const List<String> _monthNames = [
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

  DateTime _dateOnly(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  String _sectionLabel(
    DateTime date,
    DateTime today,
    DateTime yesterday,
  ) {
    final day = _dateOnly(date);

    if (day == today) {
      return 'TODAY';
    }

    if (day == yesterday) {
      return 'YESTERDAY';
    }

    return '${_monthNames[day.month - 1]} ${day.day}, ${day.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  Map<String, List<HistoryItem>> _groupHistory(
    List<HistoryItem> items,
  ) {
    final now = DateTime.now();

    final today = _dateOnly(now);

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final sortedItems = List<HistoryItem>.from(items)
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    final Map<String, List<HistoryItem>> grouped = {};

    for (final item in sortedItems) {
      final label = _sectionLabel(
        item.date,
        today,
        yesterday,
      );

      grouped.putIfAbsent(
        label,
        () => [],
      );

      grouped[label]!.add(item);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final groupedHistory = _groupHistory(_history);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,

        titleSpacing: AppSpacing.large,

        title: Text(
          'History',
          style: textTheme.headlineLarge,
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.normal,
          AppSpacing.large,
          32,
        ),

        children: [
          // ─────────────────────────────────────────────
          // History Filter
          // ─────────────────────────────────────────────

          _buildHistoryFilter(context),

          const SizedBox(
            height: AppSpacing.large,
          ),

          // ─────────────────────────────────────────────
          // History Groups
          // ─────────────────────────────────────────────

          for (final entry in groupedHistory.entries) ...[
            _buildSectionHeader(
              context,
              entry.key,
              entry.value.length,
            ),

            const SizedBox(
              height: AppSpacing.standard,
            ),

            for (final item in entry.value)
              _buildHistoryCard(
                context,
                item,
              ),

            const SizedBox(
              height: AppSpacing.normal,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryFilter(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.small,
      ),

      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusMedium,
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: _FilterButton(
              label: 'Triggered',
              selected: _showTriggeredOnly,
              onTap: () {
                setState(() {
                  _showTriggeredOnly = true;
                });
              },
            ),
          ),

          const SizedBox(
            width: AppSpacing.small,
          ),

          Expanded(
            child: _FilterButton(
              label: 'All',
              selected: !_showTriggeredOnly,
              onTap: () {
                setState(() {
                  _showTriggeredOnly = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String label,
    int itemCount,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        Text(
          '$itemCount ${itemCount == 1 ? 'event' : 'events'}',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    HistoryItem item,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.standard,
      ),

      padding: const EdgeInsets.all(
        AppSpacing.standard,
      ),

      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLarge,
        ),

        border: Border.all(
          color: colorScheme.outline,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ─────────────────────────────────────────────
          // Completed Icon
          // ─────────────────────────────────────────────

          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.check_rounded,
              size: AppSizes.icon,
              color: colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(
            width: AppSpacing.standard,
          ),

          // ─────────────────────────────────────────────
          // History Information
          // ─────────────────────────────────────────────

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.small,
                ),

                Text(
                  item.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.small,
                ),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: colorScheme.onSurfaceVariant,
                    ),

                    const SizedBox(
                      width: AppSpacing.small,
                    ),

                    Expanded(
                      child: Text(
                        item.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.standard,
          ),

          // ─────────────────────────────────────────────
          // Time
          // ─────────────────────────────────────────────

          Text(
            _formatTime(item.date),
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Filter Button
// ─────────────────────────────────────────────────────────

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: selected
          ? colorScheme.surface
          : Colors.transparent,

      borderRadius: BorderRadius.circular(
        AppSizes.radiusSmall,
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(
          AppSizes.radiusSmall,
        ),

        child: Container(
          height: 40,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSizes.radiusSmall,
            ),

            border: selected
                ? Border.all(
                    color: colorScheme.outline,
                  )
                : null,
          ),

          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: selected
                  ? FontWeight.w800
                  : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

