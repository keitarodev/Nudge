import '../models/nudge.dart';
import '../models/nudge_category.dart';
import '../models/nudge_history.dart';
import '../models/place.dart';
import '../models/sharing_preference.dart';
import '../models/notification_item.dart';
import '../models/nudge_radius.dart';

class AppData {
  // Categories
  static List<NudgeCategory> categories = [
    const NudgeCategory(id: 'food', name: 'Food'),
    const NudgeCategory(id: 'study', name: 'Study'),
    const NudgeCategory(id: 'work', name: 'Work'),
  ];

  // Saved Places
  static List<SavedPlace> places = [
    const SavedPlace(id: 'market', name: 'Market', address: 'Local Market'),
    const SavedPlace(
      id: 'university',
      name: 'University',
      address: 'University',
    ),
    const SavedPlace(id: 'office', name: 'Office', address: 'Office'),
  ];

  // Radius Settings
  static List<NudgeRadius> radii = [
    const NudgeRadius(id: '250', meters: 250),
    const NudgeRadius(id: '500', meters: 500),
    const NudgeRadius(id: '750', meters: 750),
    const NudgeRadius(id: '1000', meters: 1000),
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
      nudgeId: '1',
      title: 'Buy chicken',
      message: 'Your nudge was triggered',
      place: 'Near Market',
      createdAt: DateTime(2026, 9, 11, 18, 30),
      isRead: false,
    ),
    NotificationItem(
      id: 'notification_02',
      nudgeId: '2',
      title: 'Submit document',
      message: 'Your nudge was triggered',
      place: 'Near University',
      createdAt: DateTime(2026, 9, 11, 16, 15),
      isRead: false,
    ),
    NotificationItem(
      id: 'notification_03',
      nudgeId: '3',
      title: 'Go to work',
      message: 'Your nudge was triggered',
      place: 'Near Office',
      createdAt: DateTime(2026, 9, 10, 9, 20),
      isRead: true,
    ),
  ];
}
