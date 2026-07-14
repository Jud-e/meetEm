class Event {
  final String id;
  final String name;
  final DateTime time;
  final double lat;
  final double lng;
  final int interestCount;
  final bool isUgc;

  const Event({
    required this.id,
    required this.name,
    required this.time,
    required this.lat,
    required this.lng,
    required this.interestCount,
    this.isUgc = false,
  });
}