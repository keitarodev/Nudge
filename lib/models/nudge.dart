enum NudgeTrigger { arrive, leave, nearby }

extension NudgeTriggerLabel on NudgeTrigger {
  String get label {
    switch (this) {
      case NudgeTrigger.arrive:
        return 'When I arrive';
      case NudgeTrigger.leave:
        return 'When I leave';
      case NudgeTrigger.nearby:
        return 'When I’m nearby';
    }
  }
}

class Nudge {
  final String id;
  final String title;
  final String categoryId;
  final String placeId;
  final NudgeTrigger trigger;
  final int radius;
  final String status;
  final DateTime createdAt;
  final DateTime? lastTriggeredAt;

  const Nudge({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.placeId,
    required this.trigger,
    required this.radius,
    required this.status,
    required this.createdAt,
    this.lastTriggeredAt,
  });
}
