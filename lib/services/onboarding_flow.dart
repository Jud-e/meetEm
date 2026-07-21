import 'package:flutter/material.dart';
import 'package:meetup_app/screens/home.dart';
import '../screens/welcome_screen.dart';
import '../screens/signup.dart';
import '../screens/login.dart';
import '../screens/username_pick.dart';
import '../screens/success_screen.dart'; // adjust if you placed this somewhere else

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      onGetStarted: () => _pushSignUp(context),
      onLogin: () => _pushLogin(context),
    );
  }

  void _pushSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SignUpScreen(onCreated: () => _pushProfileSetup(context)),
    ));
  }

  void _pushLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => LoginScreen(onLoggedIn: () => _pushSuccess(context)),
    ));
  }

  void _pushProfileSetup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => UsernamePick(onContinue: () => _pushSuccess(context)),
    ));
  }

  void _pushSuccess(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => SuccessScreen(onStartExploring: () => _goToMap(context)),
    ));
  }

  void _goToMap(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => MapScreen(
  onViewEventDetails: (event) { /* existing stub */ },
  onOpenProfile: () {
    // TODO: swap for real navigation once a Profile screen exists
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Open profile')),
    );
  },
),
    ));
  }
}