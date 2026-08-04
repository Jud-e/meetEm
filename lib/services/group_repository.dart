import 'package:flutter/foundation.dart';
import '../models/group.dart';
import 'mock_groups.dart' show mockGroups;

/// In-memory group store standing in for Firestore until the backend is wired up.
/// Notifies listeners on join/create/leave so screens can rebuild reactively.
class GroupRepository extends ChangeNotifier {
  GroupRepository._() : _groups = List.of(mockGroups);
  static final instance = GroupRepository._();

  final List<Group> _groups;

  /// Which groups the current (placeholder) user belongs to. Lives here,
  /// not in screen state, so it survives navigation between screens.
  final Set<String> _joinedGroupIds = {};

  /// Groups the user explicitly left with "don't rejoin" — blocks future
  /// joins to that specific group for this (placeholder) user.
  final Set<String> _excludedGroupIds = {};

  /// Groups for [eventId], sorted fullest-first — the brief's "dense-fill"
  /// rule: bias joins toward the fullest eligible group rather than
  /// spreading people thinly across many small ones.
  List<Group> groupsForEvent(String eventId) {
    final list = _groups.where((g) => g.eventId == eventId).toList();
    list.sort((a, b) => b.memberCount.compareTo(a.memberCount));
    return list;
  }

  bool isJoined(String groupId) => _joinedGroupIds.contains(groupId);
  bool isExcluded(String groupId) => _excludedGroupIds.contains(groupId);

  /// Returns true if the user is now (or already was) a member.
  /// Returns false if the group is full, or if the user previously left
  /// with "don't rejoin".
  bool joinGroup(String groupId) {
    if (_joinedGroupIds.contains(groupId)) {
      return true; // already a member — no-op
    }
    if (_excludedGroupIds.contains(groupId)) return false;

    final index = _groups.indexWhere((g) => g.id == groupId);
    if (index == -1) return false;
    final group = _groups[index];
    if (group.isFull) return false;

    _groups[index] = Group(
      id: group.id,
      eventId: group.eventId,
      memberCount: group.memberCount + 1,
    );
    _joinedGroupIds.add(groupId);
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
    _joinedGroupIds.add(group.id);
    notifyListeners();
    return group;
  }

  /// [dontRejoin] = true excludes this group going forward (brief section
  /// 4.3's "Leave and don't rejoin"). false just opens the spot back up.
  void leaveGroup(String groupId, {bool dontRejoin = false}) {
    if (!_joinedGroupIds.contains(groupId)) return;
    _joinedGroupIds.remove(groupId);
    if (dontRejoin) _excludedGroupIds.add(groupId);

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
