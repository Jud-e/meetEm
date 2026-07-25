import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup_app/services/onboarding_flow.dart';

void main() {
  testWidgets('navigates Welcome -> Login -> Success', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(
      home: OnboardingFlow(),
    ));

    // Starts on Welcome
    expect(find.text('Get started'), findsOneWidget);

    // Go to Login instead of Sign Up
    await tester.tap(find.textContaining('Already have an account'));
    await tester.pumpAndSettle();

    expect(find.text('Good to see you again.'), findsOneWidget);

    // Fill valid credentials and submit
    await tester.enterText(find.widgetWithText(TextFormField, 'you@example.com'), 'sarah@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Your password'), 'hunter22');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pumpAndSettle();

    // Navigates to Success
    expect(find.textContaining('Welcome to'), findsOneWidget);
    expect(find.text('Start exploring'), findsOneWidget);

  });
}