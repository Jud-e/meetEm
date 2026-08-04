import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup_app/services/onboarding_flow.dart';

void main() {
  testWidgets('navigates from Welcome to Login', (tester) async {
    // Simulate a real phone-sized screen — the default test surface (800x600)
    // is too short for welcome_screen's layout and causes an overflow that
    // also throws off tap hit-testing.
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: OnboardingFlow()));

    // Starts on Welcome
    expect(find.text('Get started'), findsOneWidget);

    // Go to Login instead of Sign Up
    await tester.tap(find.textContaining('Already have an account'));
    await tester.pumpAndSettle();

    expect(find.text('Good to see you again.'), findsOneWidget);

    // Deliberately stopping here. OnboardingFlow wires LoginScreen directly
    // to the real FirebaseAuth.instance (no injection point at this level),
    // so actually submitting the form here would hit real Firebase and fail
    // in CI. login_screen_test.dart covers the real sign-in path in
    // isolation using a mocked FirebaseAuth instance instead.
  });
}
