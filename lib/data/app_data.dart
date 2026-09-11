import '../models/nudge.dart';
import '../models/nudge_category.dart';
import '../models/nudge_history.dart';
import '../models/place.dart';
import '../models/sharing_preference.dart';
import '../models/notification_item.dart';

class AppData {
  // Categories
  static List<NudgeCategory> categories = [
    const NudgeCategory(
      id: 'food',
      name: 'Food',
    ),
    const NudgeCategory(
      id: 'study',
      name: 'Study',
    ),
    const NudgeCategory(
      id: 'work',
      name: 'Work',
    ),
  ];

  // Saved Places
  static List<SavedPlace> places = [
    const SavedPlace(
      id: 'market',
      name: 'Market',
      address: 'Local Market',
    ),
    const SavedPlace(
      id: 'university',
      name: 'University',
      address: 'University',
    ),
    const SavedPlace(
      id: 'office',
      name: 'Office',
      address: 'Office',
    ),
  ];

  // Nudges
  static List<Nudge> nudges = [
    Nudge(
      id: '1',
      title: 'Buy chicken',
      categoryId: 'food',
      placeId: 'market',
      trigger: NudgeTrigger.arrive,
      radius: 200,
      status: 'active',
      createdAt: DateTime(2026, 9, 11),
    ),
    Nudge(
      id: '2',
      title: 'Submit document',
      categoryId: 'study',
      placeId: 'university',
      trigger: NudgeTrigger.arrive,
      radius: 300,
      status: 'active',
      createdAt: DateTime(2026, 9, 11),
    ),
    Nudge(
      id: '3',
      title: 'Go to work',
      categoryId: 'work',
      placeId: 'office',
      trigger: NudgeTrigger.leave,
      radius: 150,
      status: 'active',
      createdAt: DateTime(2026, 9, 11),
    ),
  ];

  // Sharing Preferences
  static List<SharingPreference> sharingPreferences = [];

  // Nudge History
  static List<NudgeHistory> history = [];

  static List<NotificationItem> notifications = [
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
}