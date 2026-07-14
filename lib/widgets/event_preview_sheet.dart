import 'package:flutter/material.dart';
import '../../../models/event.dart';

/// Quick preview shown when a map pin is tapped. Call [show] to present it.
class EventPreviewSheet extends StatelessWidget {
  final Event event;
  final VoidCallback onViewDetails;

  const EventPreviewSheet({super.key, required this.event, required this.onViewDetails});

  static Future<void> show(BuildContext context, Event event, VoidCallback onViewDetails) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EventPreviewSheet(event: event, onViewDetails: onViewDetails),
    );
  }

  String get _timeLabel {
    final now = DateTime.now();
    final diff = event.time.difference(now);
    if (diff.inDays >= 1) return 'In ${diff.inDays}d';
    if (diff.inHours >= 1) return 'In ${diff.inHours}h';
    return 'Starting soon';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (event.isUgc)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'COMMUNITY EVENT',
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          Text(event.name, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22)),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text(_timeLabel, style: theme.textTheme.bodyMedium),
              const SizedBox(width: 16),
              Icon(Icons.people_outline, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text('${event.interestCount} interested', style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onViewDetails();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('View details'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 18)],
            ),
          ),
        ],
      ),
    );
  }
}