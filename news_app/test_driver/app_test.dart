import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app/views/login_page.dart'; // Import the login page
import 'package:news_app/main.dart' as app;  // Import the app's main file


void main() {
  // This ensures the Flutter integration test framework is initialized
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches and shows the login screen', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Verify that the login screen is displayed
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('User can log in and see the post feed', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Enter a username and log in
    await tester.enterText(find.byType(TextField), 'testuser');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the post feed is displayed
    expect(find.text('Post Feed'), findsOneWidget);
  });
  
  testWidgets('Login screen shows the TextField and login button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('User can add a post', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Log in
    await tester.enterText(find.byType(TextField), 'testuser');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Add a post
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'This is a test post');
    await tester.tap(find.text('Submit Post'));
    await tester.pumpAndSettle();

    // Verify that the post is displayed in the feed
    expect(find.text('This is a test post'), findsOneWidget);
  });
}
