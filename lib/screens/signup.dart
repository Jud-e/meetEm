import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onCreated;
  const SignUpScreen({super.key, required this.onCreated});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NEW ACCOUNT', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary)),
              const SizedBox(height: 8),
              Text('Create account', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('Join MeetEm and find people near you.', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {}, // TODO: wire up Google Sign-In
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Continue with Google'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.15))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: theme.textTheme.bodyMedium),
                  ),
                  Expanded(child: Divider(color: theme.colorScheme.onSurface.withValues(alpha: 0.15))),
                ],
              ),
              const SizedBox(height: 20),
              _FieldLabel('Full name'),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(hintText: 'Sarah Chen', prefixIcon: Icon(Icons.person_outline)),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Email address'),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'you@example.com', prefixIcon: Icon(Icons.mail_outline)),
                validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Password'),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration:
                    const InputDecoration(hintText: 'At least 8 characters', prefixIcon: Icon(Icons.lock_outline)),
                validator: (v) => (v == null || v.length < 8) ? 'Minimum 8 characters' : null,
              ),
              const SizedBox(height: 16),
              _FieldLabel('Confirm password'),
              TextFormField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline)),
                validator: (v) => (v != _passwordCtrl.text) ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) widget.onCreated();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Continue'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 18)],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}