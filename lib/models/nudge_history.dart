class NudgeHistory {
  final String id;
  final String nudgeId;
  final String status;
  final DateTime triggeredAt;

  const NudgeHistory({
    required this.id,
    required this.nudgeId,
    required this.status,
    required this.triggeredAt,
  });
}
