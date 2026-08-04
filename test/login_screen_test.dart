import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:meetup_app/screens/login.dart';

void main() {
  Widget wrap(VoidCallback onLoggedIn, {MockFirebaseAuth? auth}) => MaterialApp(
    home: LoginScreen(onLoggedIn: onLoggedIn, auth: auth ?? MockFirebaseAuth()),
  );

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

  testWidgets('calls onLoggedIn when Firebase sign-in succeeds', (
    tester,
  ) async {
    var loggedIn = false;
    // MockFirebaseAuth with a pre-registered user simulates a successful
    // signInWithEmailAndPassword call without touching real Firebase.
    final mockAuth = MockFirebaseAuth(
      mockUser: MockUser(
        uid: 'test-uid',
        email: 'sarah@example.com',
        displayName: 'Sarah Chen',
      ),
    );

    await tester.pumpWidget(wrap(() => loggedIn = true, auth: mockAuth));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'you@example.com'),
      'sarah@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Your password'),
      'hunter22',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log in'));
    await tester.pumpAndSettle(); // sign-in is async — let it resolve

    expect(loggedIn, isTrue);
  });
}
