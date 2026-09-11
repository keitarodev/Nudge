import '../models/nudge.dart';
import '../models/nudge_category.dart';
import '../models/place.dart';
import '../models/sharing_preference.dart';

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
}