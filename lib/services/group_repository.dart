import 'package:flutter/foundation.dart';
import '../models/group.dart';
import 'mock_groups.dart' show mockGroups;

/// In-memory group store standing in for Firestore until the backend is wired up.
/// Notifies listeners on join/create so screens can rebuild reactively.
class GroupRepository extends ChangeNotifier {
  GroupRepository._() : _groups = List.of(mockGroups);
  static final instance = GroupRepository._();

  final List<Group> _groups;

  /// Groups for [eventId], sorted fullest-first — this is the brief's
  /// "dense-fill" rule: bias joins toward the fullest eligible group
  /// rather than spreading people thinly across many small ones.
  List<Group> groupsForEvent(String eventId) {
    final list = _groups.where((g) => g.eventId == eventId).toList();
    list.sort((a, b) => b.memberCount.compareTo(a.memberCount));
    return list;
  }

  /// Returns false if the group is already full (caller should show
  /// "Start a new group" instead in that case).
  bool joinGroup(String groupId) {
    final index = _groups.indexWhere((g) => g.id == groupId);
    if (index == -1) return false;
    final group = _groups[index];
    if (group.isFull) return false;
    _groups[index] = Group(
      id: group.id,
      eventId: group.eventId,
      memberCount: group.memberCount + 1,
    );
    notifyListeners();
    return true;
  }

  Group createGroup(String eventId) {
    final group = Group(
      id: 'g-${DateTime.now().microsecondsSinceEpoch}',
      eventId: eventId,
      memberCount: 1,
    );
    _groups.add(group);
    notifyListeners();
    return group;
  }

  /// [dontRejoin] is accepted now for API shape but not enforced yet —
  /// real "excluded from this group" tracking needs per-user membership
  /// docs, which arrives with real auth.
  void leaveGroup(String groupId, {bool dontRejoin = false}) {
    final index = _groups.indexWhere((g) => g.id == groupId);
    if (index == -1) return;
    final group = _groups[index];
    final newCount = (group.memberCount - 1).clamp(0, Group.capacity);
    _groups[index] = Group(
      id: group.id,
      eventId: group.eventId,
      memberCount: newCount,
    );
    notifyListeners();
  }
}
