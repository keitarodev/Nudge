import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/notification_item.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedStatus = 'All';
  String _selectedTime = 'All';

  // Temporary V1 test data
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: 'notification_01',
      title: 'Buy medicine',
      message: 'Don’t forget to buy medicine',
      place: 'Near Pharmacy',
      createdAt: DateTime(2026, 9, 11, 18, 30),
      isRead: false,
    ),
    NotificationItem(
      id: 'notification_02',
      title: 'Buy groceries',
      message: 'Remember to buy groceries',
      place: 'Near Supermarket',
      createdAt: DateTime(2026, 9, 11, 16, 15),
      isRead: false,
    ),
    NotificationItem(
      id: 'notification_03',
      title: 'Submit document',
      message: 'Don’t forget your document',
      place: 'Near University',
      createdAt: DateTime(2026, 9, 10, 9, 20),
      isRead: true,
    ),
    NotificationItem(
      id: 'notification_04',
      title: 'Gym session',
      message: 'Your gym reminder was triggered',
      place: 'Near FitZone',
      createdAt: DateTime(2026, 9, 8, 7, 30),
      isRead: true,
    ),
    NotificationItem(
      id: 'notification_05',
      title: 'Coffee with Dara',
      message: 'Remember your coffee plan',
      place: 'Near Brown Coffee',
      createdAt: DateTime(2026, 9, 1, 11, 30),
      isRead: false,
    ),
  ];

  DateTime _getDateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isToday(DateTime date) {
    return _getDateOnly(date) == _getDateOnly(DateTime.now());
  }

  bool _isThisWeek(DateTime date) {
    DateTime today = _getDateOnly(DateTime.now());

    DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));

    DateTime weekEnd = weekStart.add(const Duration(days: 6));

    DateTime itemDate = _getDateOnly(date);

    return !itemDate.isBefore(weekStart) && !itemDate.isAfter(weekEnd);
  }

  bool _isThisMonth(DateTime date) {
    DateTime today = DateTime.now();

    return date.year == today.year && date.month == today.month;
  }

  List<NotificationItem> _getFilteredNotifications() {
    List<NotificationItem> filtered = _notifications;

    if (_selectedStatus == 'Unread') {
      filtered = filtered.where((item) {
        return !item.isRead;
      }).toList();
    }

    if (_selectedStatus == 'Read') {
      filtered = filtered.where((item) {
        return item.isRead;
      }).toList();
    }

    if (_selectedTime == 'Today') {
      filtered = filtered.where((item) {
        return _isToday(item.createdAt);
      }).toList();
    }

    if (_selectedTime == 'This Week') {
      filtered = filtered.where((item) {
        return _isThisWeek(item.createdAt);
      }).toList();
    }

    if (_selectedTime == 'This Month') {
      filtered = filtered.where((item) {
        return _isThisMonth(item.createdAt);
      }).toList();
    }

    return filtered;
  }

  String _getDateLabel(DateTime date) {
    DateTime today = _getDateOnly(DateTime.now());

    DateTime yesterday = today.subtract(const Duration(days: 1));

    DateTime itemDate = _getDateOnly(date);

    if (itemDate == today) {
      return 'TODAY';
    }

    if (itemDate == yesterday) {
      return 'YESTERDAY';
    }

    const List<String> months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    return '${months[itemDate.month - 1]} '
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
      hour -= 12;
    }

    if (hour == 0) {
      hour = 12;
    }

    String minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }

  Map<String, List<NotificationItem>> _groupNotifications(
    List<NotificationItem> items,
  ) {
    List<NotificationItem> sortedNotifications = List.from(items);

    sortedNotifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    Map<String, List<NotificationItem>> grouped = {};

    for (NotificationItem item in sortedNotifications) {
      String label = _getDateLabel(item.createdAt);

      if (!grouped.containsKey(label)) {
        grouped[label] = [];
      }

      grouped[label]!.add(item);
    }

    return grouped;
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem item) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.normal),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
              : AppColors.outlineLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(width: AppSpacing.normal),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTextStyles.cardTitle.copyWith(
                          fontWeight: item.isRead
                              ? FontWeight.w600
                              : FontWeight.w800,
                        ),
                      ),
                    ),

                    if (!item.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: AppSpacing.small),

                Text(item.message, style: AppTextStyles.body),

                const SizedBox(height: AppSpacing.small),

                Text(
                  '${item.place} • ${_getTime(item.createdAt)}',
                  style: AppTextStyles.smallText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String message = 'No notifications';

    if (_selectedStatus == 'Unread') {
      message = 'No unread notifications';
    } else if (_selectedStatus == 'Read') {
      message = 'No read notifications';
    } else if (_selectedTime != 'All') {
      message = 'No notifications for this time';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 56,
              color: theme.colorScheme.outline,
            ),

            const SizedBox(height: AppSpacing.normal),

            Text(
              message,
              style: AppTextStyles.sectionHeading,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _selectFilter(String value) {
    setState(() {
      if (value == 'status_all') {
        _selectedStatus = 'All';
      } else if (value == 'status_unread') {
        _selectedStatus = 'Unread';
      } else if (value == 'status_read') {
        _selectedStatus = 'Read';
      } else if (value == 'time_all') {
        _selectedTime = 'All';
      } else if (value == 'time_today') {
        _selectedTime = 'Today';
      } else if (value == 'time_week') {
        _selectedTime = 'This Week';
      } else if (value == 'time_month') {
        _selectedTime = 'This Month';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<NotificationItem> filteredNotifications = _getFilteredNotifications();

    Map<String, List<NotificationItem>> groupedNotifications =
        _groupNotifications(filteredNotifications);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        titleSpacing: AppSpacing.standard,

        title: Text('Notifications', style: AppTextStyles.heading),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),

        actions: [
          PopupMenuButton<String>(
            onSelected: _selectFilter,

            icon: const Icon(Icons.tune_rounded),

            tooltip: 'Filter notifications',

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),

            itemBuilder: (context) {
              return [
                const PopupMenuItem<String>(
                  enabled: false,
                  child: Text(
                    'STATUS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'status_all',
                  child: Row(
                    children: [
                      if (_selectedStatus == 'All')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedStatus != 'All') const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('All'),
                    ],
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'status_unread',
                  child: Row(
                    children: [
                      if (_selectedStatus == 'Unread')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedStatus != 'Unread')
                        const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('Unread'),
                    ],
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'status_read',
                  child: Row(
                    children: [
                      if (_selectedStatus == 'Read')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedStatus != 'Read') const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('Read'),
                    ],
                  ),
                ),

                const PopupMenuDivider(),

                const PopupMenuItem<String>(
                  enabled: false,
                  child: Text(
                    'TIME',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'time_all',
                  child: Row(
                    children: [
                      if (_selectedTime == 'All')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedTime != 'All') const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('All'),
                    ],
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'time_today',
                  child: Row(
                    children: [
                      if (_selectedTime == 'Today')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedTime != 'Today') const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('Today'),
                    ],
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'time_week',
                  child: Row(
                    children: [
                      if (_selectedTime == 'This Week')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedTime != 'This Week')
                        const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('This Week'),
                    ],
                  ),
                ),

                PopupMenuItem<String>(
                  value: 'time_month',
                  child: Row(
                    children: [
                      if (_selectedTime == 'This Month')
                        Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),

                      if (_selectedTime != 'This Month')
                        const SizedBox(width: 18),

                      const SizedBox(width: AppSpacing.small),

                      const Text('This Month'),
                    ],
                  ),
                ),
              ];
            },
          ),

          const SizedBox(width: AppSpacing.small),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.normal),

            if (_selectedStatus != 'All' || _selectedTime != 'All')
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: AppSpacing.small,
                    runSpacing: AppSpacing.small,
                    children: [
                      if (_selectedStatus != 'All')
                        _buildFilterChip(context, _selectedStatus),
                      if (_selectedTime != 'All')
                        _buildFilterChip(context, _selectedTime),
                    ],
                  ),
                ),
              ),

            if (_selectedStatus != 'All' || _selectedTime != 'All')
              const SizedBox(height: AppSpacing.normal),

            Expanded(
              child: filteredNotifications.isEmpty
                  ? _buildEmptyState(context)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.large,
                        0,
                        AppSpacing.large,
                        AppSpacing.extraLarge,
                      ),
                      children: [
                        for (MapEntry<String, List<NotificationItem>> group
                            in groupedNotifications.entries) ...[
                          Text(group.key, style: AppTextStyles.sectionHeading),

                          const SizedBox(height: AppSpacing.normal),

                          for (int i = 0; i < group.value.length; i++) ...[
                            _buildNotificationCard(context, group.value[i]),

                            if (i != group.value.length - 1)
                              const SizedBox(height: AppSpacing.normal),
                          ],

                          const SizedBox(height: AppSpacing.large),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.normal,
        vertical: AppSpacing.small,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter_alt_outlined,
            size: 16,
            color: theme.colorScheme.onPrimaryContainer,
          ),

          const SizedBox(width: AppSpacing.small),

          Text(
            label,
            style: AppTextStyles.smallText.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
