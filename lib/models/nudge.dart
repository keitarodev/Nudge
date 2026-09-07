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
  final String title;
  final String category;
  final NudgeTrigger trigger;
  final String placeName;
  final double radiusMeters;

  const Nudge({
    required this.title,
    required this.category,
    required this.trigger,
    required this.placeName,
    required this.radiusMeters,
  });
}
