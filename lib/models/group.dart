class Group {
  final String id;
  final String eventId;
  final int memberCount;

  static const capacity = 20;

  const Group({
    required this.id,
    required this.eventId,
    required this.memberCount,
  });

  bool get isFull => memberCount >= capacity;
}
