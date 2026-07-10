import 'package:flutter/material.dart';

class UsernamePick extends StatefulWidget {
  final VoidCallback onContinue;
  const UsernamePick({super.key, required this.onContinue});

  @override
  State<UsernamePick> createState() => _UsernamePickState();
}

class _UsernamePickState extends State<UsernamePick> {
  final _usernameCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('STEP 2 OF 3', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text('Pick a username', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text('You can always change this later.', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 28),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                    child: Icon(Icons.person_outline, size: 40, color: theme.colorScheme.primary),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                      ),
                      child: const Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text('Username', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 6),
            TextField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(hintText: '@sarah.chen', prefixIcon: Icon(Icons.alternate_email)),
            ),
            const SizedBox(height: 8),
            Text(
              'This is how other people will find and recognise you on MeetEm.',
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: widget.onContinue,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Continue'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 18)],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}