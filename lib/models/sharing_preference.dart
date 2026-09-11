class SharingPreference {
  final String id;
  final String nudgeId;
  final bool isShared;
  final List<String> sharedWith;

  const SharingPreference({
    required this.id,
    required this.nudgeId,
    this.isShared = false,
    this.sharedWith = const [],
  });
}