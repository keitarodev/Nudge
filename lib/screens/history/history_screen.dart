import 'package:flutter/material.dart';

import '../../models/history_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  List<HistoryItem> get _testHistory => [
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
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final appBarColor = isDark
        ? const Color(0xFF222222)
        : Colors.white;

    final appBarTextColor = isDark
        ? Colors.white
        : AppColors.color1;

    final now = DateTime.now();

    final today = _dateOnly(now);

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final items = List<HistoryItem>.from(
      _testHistory,
    )..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    final Map<String, List<HistoryItem>> grouped = {};

    for (final item in items) {
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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: appBarTextColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 96,
        titleSpacing: AppSpacing.large,

        title: Text(
          'History',
          style: AppTextStyles.heading.copyWith(
            color: appBarTextColor,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.normal,
          AppSpacing.large,
          AppSpacing.large,
        ),
        children: [
          for (final entry in grouped.entries) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.standard,
              ),
              child: Text(
                entry.key,
                style: AppTextStyles.sectionHeading.copyWith(
                  color: isDark
                      ? AppColors.color6
                      : AppColors.color5,
                ),
              ),
            ),

            for (final item in entry.value)
              _buildHistoryCard(
                context,
                item,
              ),

            const SizedBox(
              height: AppSpacing.standard,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    HistoryItem item,
  ) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark
        ? AppColors.color2
        : Colors.white;

    final titleColor = isDark
        ? Colors.white
        : AppColors.color1;

    final categoryColor = isDark
        ? AppColors.color6
        : AppColors.color5;

    final locationColor = isDark
        ? AppColors.color6
        : AppColors.color5;

    final iconBackgroundColor = isDark
        ? AppColors.color4
        : AppColors.color8;

    final iconColor = isDark
        ? AppColors.color8
        : AppColors.color4;

    final borderColor = isDark
        ? AppColors.color2
        : AppColors.color7;

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.standard,
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.large,
        vertical: AppSpacing.standard,
      ),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(
          AppSizes.radiusLarge,
        ),

        border: Border.all(
          color: borderColor,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.check,
              size: AppSizes.icon,
              color: iconColor,
            ),
          ),

          const SizedBox(
            width: AppSpacing.large,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: titleColor,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.small,
                ),

                Text(
                  item.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: categoryColor,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.small,
                ),

                Text(
                  item.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: locationColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: AppSpacing.standard,
          ),

          Text(
            _formatTime(item.date),
            style: AppTextStyles.body.copyWith(
              color: locationColor,
            ),
          ),
        ],
      ),
    );
  }
}