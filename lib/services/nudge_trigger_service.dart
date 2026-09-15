import '../data/app_data.dart';
import '../models/nudge.dart';
import '../models/notification_item.dart';
import '../models/nudge_history.dart';

class NudgeTriggerService {
  static void triggerNudge(Nudge nudge) {
    final now = DateTime.now();

    AppData.notifications.add(
      NotificationItem(
        id: '${now.millisecondsSinceEpoch}_notification',
        nudgeId: nudge.id,
        title: nudge.title,
        message: 'Your nudge was triggered',
        place: _getPlaceName(nudge.placeId),
        createdAt: now,
        isRead: false,
      ),
    );
  }

  static void completeNudge(Nudge nudge) {
    final now = DateTime.now();

    AppData.history.add(
      NudgeHistory(
        id: now.millisecondsSinceEpoch.toString(),
        nudgeId: nudge.id,
        status: 'completed',
        triggeredAt: now,
      ),
    );

    final index = AppData.nudges.indexWhere((item) => item.id == nudge.id);

    if (index != -1) {
      AppData.nudges[index] = Nudge(
        id: nudge.id,
        title: nudge.title,
        categoryId: nudge.categoryId,
        placeId: nudge.placeId,
        trigger: nudge.trigger,
        radius: nudge.radius,
        status: 'completed',
        createdAt: nudge.createdAt,
        lastTriggeredAt: now,
      );
    }
  }

  static String _getPlaceName(String placeId) {
    for (final place in AppData.places) {
      if (place.id == placeId) {
        return place.name;
      }
    }

    return 'Unknown place';
  }
}
