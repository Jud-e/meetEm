import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup_app/screens/login.dart';

void main() {
  Widget wrap(VoidCallback onLoggedIn) =>
      MaterialApp(home: LoginScreen(onLoggedIn: onLoggedIn));

  testWidgets('shows validation errors and does not log in with empty fields', (
    tester,
  ) async {
    var loggedIn = false;
    await tester.pumpWidget(wrap(() => loggedIn = true));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(loggedIn, isFalse);
  });

  testWidgets('rejects an email missing the @ symbol', (tester) async {
    var loggedIn = false;
    await tester.pumpWidget(wrap(() => loggedIn = true));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'you@example.com'),
      'not-an-email',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(loggedIn, isFalse);
  });

  testWidgets('calls onLoggedIn when both fields are valid', (tester) async {
    var loggedIn = false;
    await tester.pumpWidget(wrap(() => loggedIn = true));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'you@example.com'),
      'sarah@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your password'),
      'hunter22',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pump();

    expect(loggedIn, isTrue);
  });
}
