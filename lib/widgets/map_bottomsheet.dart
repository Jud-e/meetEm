import 'package:flutter/material.dart';
import '../../../models/event.dart';

class MapBottomSheet extends StatelessWidget {
  final List<Event> suggestedEvents;
  final VoidCallback onOpenProfile;
  final void Function(Event event) onSelectEvent;

  const MapBottomSheet({
    super.key,
    required this.suggestedEvents,
    required this.onOpenProfile,
    required this.onSelectEvent,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.32,
      minChildSize: 0.18,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, -2))],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                          const SizedBox(width: 10),
                          Text('Search MeetEm', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onOpenProfile,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                      child: Icon(Icons.person, color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Nearby now', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...suggestedEvents.map((event) => _EventTile(event: event, onTap: () => onSelectEvent(event))),
            ],
          ),
        );
      },
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  const _EventTile({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: (event.isUgc ? Colors.orange : theme.colorScheme.primary).withValues(alpha: 0.15),
              child: Icon(
                event.isUgc ? Icons.groups_outlined : Icons.event_outlined,
                size: 18,
                color: event.isUgc ? Colors.orange : theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.name, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
                  Text('${event.interestCount} interested', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}