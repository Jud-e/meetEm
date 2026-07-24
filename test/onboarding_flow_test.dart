import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup_app/services/onboarding_flow.dart';

void main() {
  testWidgets('navigates Welcome -> Login -> Success and fires onFinished', (tester) async {
    var finished = false;

    await tester.pumpWidget(MaterialApp(
      home: OnboardingFlow(),
    ));

    // Starts on Welcome
    expect(find.text('Get started'), findsOneWidget);

    // Go to Login instead of Sign Up
    await tester.tap(find.textContaining('Already have an account'));
    await tester.pumpAndSettle(); // waits out the push route animation

    expect(find.text('Log in'), findsWidgets); // appears in both label + button
    expect(find.text('Good to see you again.'), findsOneWidget);

    // Fill valid credentials and submit
    await tester.enterText(find.widgetWithText(TextFormField, 'you@example.com'), 'sarah@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Your password'), 'hunter22');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pumpAndSettle();

    // Landed on Success
    expect(find.textContaining('Welcome to'), findsOneWidget);
    expect(find.text('Start exploring'), findsOneWidget);

    // onFinished fires when the user taps through
    await tester.tap(find.text('Start exploring'));
    await tester.pump();
    expect(finished, isTrue);
  });
}