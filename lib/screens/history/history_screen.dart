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

  // Current selected filter
  String _selectedFilter = 'All';

  // Temporary test data
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

  // Month names
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

  // ─────────────────────────────────────────────
  // Get Date Without Time
  // ─────────────────────────────────────────────

  DateTime _getDateOnly(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  // ─────────────────────────────────────────────
  // Get Date Section
  // ─────────────────────────────────────────────

  String _getDateLabel(DateTime date) {
    DateTime today = _getDateOnly(DateTime.now());

    DateTime yesterday = today.subtract(
      const Duration(days: 1),
    );

    DateTime itemDate = _getDateOnly(date);

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

  // ─────────────────────────────────────────────
  // Format Time
  // ─────────────────────────────────────────────

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

    String minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  // ─────────────────────────────────────────────
  // Filter History
  // ─────────────────────────────────────────────

  List<HistoryItem> _getFilteredHistory() {
    DateTime today = _getDateOnly(DateTime.now());

    if (_selectedFilter == 'All') {
      return _history;
    }

    if (_selectedFilter == 'Today') {
      return _history.where((item) {
        return _getDateOnly(item.date) == today;
      }).toList();
    }

    if (_selectedFilter == 'This Week') {
      DateTime weekStart = today.subtract(
        Duration(days: today.weekday - 1),
      );

      return _history.where((item) {
        DateTime itemDate = _getDateOnly(item.date);

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
      return _history.where((item) {
        return item.date.year == today.year &&
            item.date.month == today.month;
      }).toList();
    }

    return _history;
  }

  // ─────────────────────────────────────────────
  // Group History
  // ─────────────────────────────────────────────

  Map<String, List<HistoryItem>> _groupHistory(
    List<HistoryItem> items,
  ) {
    // Sort newest first
    List<HistoryItem> sortedHistory =
        List.from(items);

    sortedHistory.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    Map<String, List<HistoryItem>> grouped = {};

    for (HistoryItem item in sortedHistory) {
      String label = _getDateLabel(item.date);

      if (!grouped.containsKey(label)) {
        grouped[label] = [];
      }

      grouped[label]!.add(item);
    }

    return grouped;
  }

  // ─────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    ColorScheme colors = theme.colorScheme;

    TextTheme text = theme.textTheme;

    List<HistoryItem> filteredHistory =
        _getFilteredHistory();

    Map<String, List<HistoryItem>> groupedHistory =
        _groupHistory(filteredHistory);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Column(
          children: [

            // ─────────────────────────────────────
            // Header
            // ─────────────────────────────────────

            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.large,
                AppSpacing.normal,
                AppSpacing.large,
                0,
              ),

              child: Row(
                children: [

                  // Back Button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    padding: EdgeInsets.zero,

                    constraints: const BoxConstraints(
                      minWidth: 42,
                      minHeight: 42,
                    ),

                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 28,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(
                    width: AppSpacing.normal,
                  ),

                  // History
                  Expanded(
                    child: Text(
                      'History',

                      style: text.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  // Filter Button
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },

                    icon: Icon(
                      Icons.tune_rounded,
                      size: 27,
                      color: colors.onSurface,
                    ),

                    tooltip: 'Filter history',

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusMedium,
                      ),
                    ),

                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'All',
                          child: Row(
                            children: [
                              if (_selectedFilter == 'All')
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),

                              if (_selectedFilter != 'All')
                                const SizedBox(width: 18),

                              const SizedBox(
                                width: AppSpacing.small,
                              ),

                              Text(
                                'All',
                                style:
                                    AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),

                        PopupMenuItem(
                          value: 'Today',
                          child: Row(
                            children: [
                              if (_selectedFilter == 'Today')
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),

                              if (_selectedFilter != 'Today')
                                const SizedBox(width: 18),

                              const SizedBox(
                                width: AppSpacing.small,
                              ),

                              Text(
                                'Today',
                                style:
                                    AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),

                        PopupMenuItem(
                          value: 'This Week',
                          child: Row(
                            children: [
                              if (_selectedFilter ==
                                  'This Week')
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),

                              if (_selectedFilter !=
                                  'This Week')
                                const SizedBox(width: 18),

                              const SizedBox(
                                width: AppSpacing.small,
                              ),

                              Text(
                                'This Week',
                                style:
                                    AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),

                        PopupMenuItem(
                          value: 'This Month',
                          child: Row(
                            children: [
                              if (_selectedFilter ==
                                  'This Month')
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),

                              if (_selectedFilter !=
                                  'This Month')
                                const SizedBox(width: 18),

                              const SizedBox(
                                width: AppSpacing.small,
                              ),

                              Text(
                                'This Month',
                                style:
                                    AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.large,
            ),

            // ─────────────────────────────────────
            // Current Filter
            // ─────────────────────────────────────

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

                      borderRadius:
                          BorderRadius.circular(
                        AppSizes.radiusSmall,
                      ),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 16,
                          color:
                              colors.onPrimaryContainer,
                        ),

                        const SizedBox(
                          width: AppSpacing.small,
                        ),

                        Text(
                          _selectedFilter,

                          style:
                              text.bodySmall?.copyWith(
                            color:
                                colors.onPrimaryContainer,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            if (_selectedFilter != 'All')
              const SizedBox(
                height: AppSpacing.large,
              ),

            // ─────────────────────────────────────
            // History List
            // ─────────────────────────────────────

            Expanded(
              child: filteredHistory.isEmpty
                  ? _buildEmptyState(context)
                  : ListView(
                      padding:
                          const EdgeInsets.fromLTRB(
                        AppSpacing.large,
                        0,
                        AppSpacing.large,
                        AppSpacing.extraLarge,
                      ),

                      children: [

                        for (var group
                            in groupedHistory.entries) ...[

                          // Date
                          _buildSectionHeader(
                            context,
                            group.key,
                            group.value.length,
                          ),

                          const SizedBox(
                            height: AppSpacing.normal,
                          ),

                          // Items
                          for (HistoryItem item
                              in group.value)
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

  // ─────────────────────────────────────────────
  // Section Header
  // ─────────────────────────────────────────────

  Widget _buildSectionHeader(
    BuildContext context,
    String label,
    int count,
  ) {
    ThemeData theme = Theme.of(context);

    return Row(
      children: [

        Expanded(
          child: Text(
            label,

            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color:
                  theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        Text(
          '$count ${count == 1 ? 'event' : 'events'}',

          style:
              theme.textTheme.bodySmall?.copyWith(
            color:
                theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // History Card
  // ─────────────────────────────────────────────

  Widget _buildHistoryCard(
    BuildContext context,
    HistoryItem item,
  ) {
    ThemeData theme = Theme.of(context);

    ColorScheme colors = theme.colorScheme;

    TextTheme text = theme.textTheme;

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
          AppSizes.radiusMedium,
        ),

        border: Border.all(
          color: colors.outline,
        ),
      ),

      child: Row(
        children: [

          // Check Icon
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

          // Information
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Title
                Text(
                  item.title,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.micro,
                ),

                // Location + Category
                Text(
                  '${item.location} · ${item.category}',

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: text.bodySmall?.copyWith(
                    color:
                        colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.small,
          ),

          // Time
          Text(
            _getTime(item.date),

            style: text.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color:
                  colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Empty State
  // ─────────────────────────────────────────────

  Widget _buildEmptyState(
    BuildContext context,
  ) {
    ThemeData theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

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

            style:
                theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: AppSpacing.small,
          ),

          Text(
            'There are no events for this filter.',

            style:
                theme.textTheme.bodyMedium?.copyWith(
              color:
                  theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}