import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String displayName;
  final String username;
  final VoidCallback onLogOut;

  const ProfileScreen({
    super.key,
    this.displayName = 'Sarah Chen',
    this.username = '@sarah.chen',
    required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                      child: Icon(Icons.person, size: 44, color: theme.colorScheme.primary),
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
                        child: const Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(displayName, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22)),
                const SizedBox(height: 2),
                Text(username, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _SectionLabel('Account'),
          _ProfileTile(icon: Icons.person_outline, label: 'Edit profile', onTap: () {}),
          _ProfileTile(icon: Icons.lock_outline, label: 'Privacy & safety', onTap: () {}),
          _ProfileTile(icon: Icons.notifications_none, label: 'Notifications', trailing: 'Post-V1', onTap: () {}),
          const SizedBox(height: 24),
          _SectionLabel('App'),
          _ProfileTile(icon: Icons.palette_outlined, label: 'Appearance', trailing: 'System', onTap: () {}),
          _ProfileTile(icon: Icons.help_outline, label: 'Help & support', onTap: () {}),
          _ProfileTile(icon: Icons.info_outline, label: 'About MeetEm', onTap: () {}),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: onLogOut,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
              side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.4)),
            ),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback onTap;

  const _ProfileTile({required this.icon, required this.label, this.trailing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface))),
            if (trailing != null) ...[
              Text(trailing!, style: theme.textTheme.bodyMedium),
              const SizedBox(width: 6),
            ],
            Icon(Icons.chevron_right, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}