import 'package:flutter/material.dart';
import '../services/group_eligibility.dart';
import '../models/event.dart';
import '../models/group.dart';
import '../services/group_repository.dart';
import 'group_chat.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  final void Function(Group group)? onJoinGroup;
  final void Function(Event event)? onCreateGroup;

  const EventDetailScreen({
    super.key,
    required this.event,
    this.onJoinGroup,
    this.onCreateGroup,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _repo = GroupRepository.instance;

  late bool _interested;
  late int _interestCount;

  @override
  void initState() {
    super.initState();
    _interested = false;
    _interestCount = widget.event.interestCount;
  }

  void _toggleInterest() {
    setState(() {
      _interested = !_interested;
      _interestCount += _interested ? 1 : -1;
    });
  }

  /// Handles both "join then open chat" and "already a member, just
  /// reopen chat" — membership is checked against the shared repository,
  /// not local state, so this works correctly no matter how many times
  /// this screen has been pushed fresh.
  void _handleGroupTap(Group group) {
    final alreadyMember = _repo.isJoined(group.id);
    if (!alreadyMember) {
      final joined = _repo.joinGroup(group.id);
      if (!joined) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'That group just filled up — try another or start a new one.',
            ),
          ),
        );
        return;
      }
      widget.onJoinGroup?.call(group);
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            GroupChatScreen(group: group, eventName: widget.event.name),
      ),
    );
  }

  void _handleCreate() {
    final group = _repo.createGroup(widget.event.id);
    widget.onCreateGroup?.call(widget.event);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            GroupChatScreen(group: group, eventName: widget.event.name),
      ),
    );
  }

  String get _timeLabel {
    final diff = widget.event.time.difference(DateTime.now());
    if (diff.inDays >= 1) {
      return 'In ${diff.inDays} day${diff.inDays == 1 ? '' : 's'}';
    }
    if (diff.inHours >= 1) {
      return 'In ${diff.inHours} hour${diff.inHours == 1 ? '' : 's'}';
    }
    return 'Starting soon';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = widget.event;
    final eligible = canCreateGroup(event);

    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: _repo,
        builder: (context, _) {
          final groups = _repo.groupsForEvent(event.id);
          final allGroupsFull =
              groups.isNotEmpty && groups.every((g) => g.isFull);

          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            children: [
              if (event.isUgc)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'COMMUNITY EVENT',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              Text(event.name, style: theme.textTheme.headlineMedium),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 6),
                  Text(_timeLabel, style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 24),

              // Interest flow
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$_interestCount interested',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _toggleInterest,
                    icon: Icon(
                      _interested ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                    ),
                    label: Text(
                      _interested ? "I'm interested" : 'Mark interest',
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                      foregroundColor: _interested
                          ? theme.colorScheme.primary
                          : null,
                      side: BorderSide(
                        color: _interested
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                ],
              ),

              if (event.isUgc && !eligible) ...[
                const SizedBox(height: 8),
                Text(
                  'Needs $kInterestThreshold+ interested before a group can be created.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],

              const SizedBox(height: 28),
              Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              const SizedBox(height: 20),

              Text('Groups', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),

              if (groups.isEmpty)
                Text(
                  eligible
                      ? 'No groups yet — be the first to start one.'
                      : 'No groups yet. Once enough people are interested, anyone can start one.',
                  style: theme.textTheme.bodyMedium,
                )
              else
                ...groups.map(
                  (group) => _GroupTile(
                    group: group,
                    isMember: _repo.isJoined(group.id),
                    isExcluded: _repo.isExcluded(group.id),
                    onTap: () => _handleGroupTap(group),
                  ),
                ),

              const SizedBox(height: 20),

              if (eligible && (groups.isEmpty || allGroupsFull))
                OutlinedButton.icon(
                  onPressed: _handleCreate,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    groups.isEmpty ? 'Create a group' : 'Start a new group',
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _GroupTile extends StatelessWidget {
  final Group group;
  final bool isMember;
  final bool isExcluded;
  final VoidCallback onTap;
  const _GroupTile({
    required this.group,
    required this.isMember,
    required this.isExcluded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Members can always reopen their own group, even if it's since filled
    // up with other people. Non-members need room AND not to be excluded.
    final canTap = isMember || (!group.isFull && !isExcluded);

    return InkWell(
      onTap: canTap ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.15,
              ),
              child: Icon(
                Icons.groups_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${group.memberCount}/${Group.capacity} members',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            if (isMember)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Joined',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ],
              )
            else if (isExcluded)
              Text('Left', style: theme.textTheme.bodyMedium)
            else if (group.isFull)
              Text('Full', style: theme.textTheme.bodyMedium)
            else
              TextButton(onPressed: onTap, child: const Text('Join')),
          ],
        ),
      ),
    );
  }
}
