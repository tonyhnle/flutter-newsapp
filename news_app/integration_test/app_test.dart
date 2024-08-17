import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app/views/login_page.dart'; // Import the login page
import 'package:news_app/main.dart' as app;  // Import the app's main file

void main() {
  // This ensures the Flutter integration test framework is initialized
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches and shows the login screen', (WidgetTester tester) async {
    print('Starting test: App launches and shows the login screen');

    // Start the app
    app.main();
    await tester.pumpAndSettle();
    print('App launched and settled');

    // Verify that the login screen is displayed
    expect(find.text('Login'), findsOneWidget);
    print('Login screen displayed');
  });

  testWidgets('User can log in and see the post feed', (WidgetTester tester) async {
    print('Starting test: User can log in and see the post feed');

    // Start the app
    app.main();
    await tester.pumpAndSettle();
    print('App launched and settled');

    // Enter a username and log in
    await tester.enterText(find.byType(TextField), 'testuser');
    print('Entered username');
    await tester.tap(find.text('Login'));
    print('Tapped Login button');
    await tester.pumpAndSettle();
    print('Logged in and settled');

    // Verify that the post feed is displayed
    expect(find.text('Post Feed'), findsOneWidget);
    print('Post feed displayed');
  });

  testWidgets('Login screen shows the TextField and login button', (WidgetTester tester) async {
    print('Starting test: Login screen shows the TextField and login button');
    
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));
    print('Login screen pumped');

    expect(find.byType(TextField), findsOneWidget);
    print('TextField found');
    expect(find.text('Login'), findsOneWidget);
    print('Login button found');
  });

  testWidgets('User can add a post', (WidgetTester tester) async {
    print('Starting test: User can add a post');

    // Start the app
    app.main();
    await tester.pumpAndSettle();
    print('App launched and settled');

    // Log in
    await tester.enterText(find.byType(TextField), 'testuser');
    print('Entered username');
    await tester.tap(find.text('Login'));
    print('Tapped Login button');
    await tester.pumpAndSettle();
    print('Logged in and settled');

    // Add a post
    await tester.tap(find.byIcon(Icons.add));
    print('Tapped add post button');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'This is a test post');
    print('Entered post content');
    await tester.tap(find.text('Submit Post'));
    print('Tapped Submit Post button');
    await tester.pumpAndSettle();

    // Verify that the post is displayed in the feed
    expect(find.text('This is a test post'), findsOneWidget);
    print('Post is displayed in the feed');
  });
}
