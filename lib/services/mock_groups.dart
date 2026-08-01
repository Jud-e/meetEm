import '../models/group.dart';

/// Mock group data. Keyed loosely by event id so the Event Detail screen
/// has a mix of states to demo: no groups yet, groups with room, and a
/// full group (to show the "start a new group" overflow case).
final mockGroups = <Group>[
  Group(id: 'g1', eventId: 'e2', memberCount: 12), // Gastown Night Market — room to join
  Group(id: 'g2', eventId: 'e2', memberCount: 20), // same event — full, demonstrates overflow
  Group(id: 'g3', eventId: 'e5', memberCount: 4), // Surrey Tech Mixer — small group
];

List<Group> groupsForEvent(String eventId) => mockGroups.where((g) => g.eventId == eventId).toList();