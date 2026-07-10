import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String userName;
  final VoidCallback onStartExploring;

  const SuccessScreen({super.key, this.userName = 'Sarah', required this.onStartExploring});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(Icons.check, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 24),
            Text('Welcome to\nMeetEm, $userName!', textAlign: TextAlign.center, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              'Your account is ready. Start meeting people near you.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Stat(value: '2.4M', label: 'Members'),
                _Stat(value: '140+', label: 'Topics'),
                _Stat(value: '4.8★', label: 'Rating'),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartExploring,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Start exploring'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 18)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleMedium),
        const SizedBox(height: 2),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}