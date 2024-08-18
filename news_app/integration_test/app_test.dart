import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User can log in and see the post feed', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();  // Ensure the app is fully loaded

    // Verify that the login screen is displayed
    expect(find.byType(TextField), findsOneWidget);
    
    // Enter a username and log in
    await tester.enterText(find.byType(TextField), 'testuser');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();  // Wait for navigation to complete

    // Verify that the post feed is displayed
    expect(find.text('Post Feed'), findsOneWidget);
  });
}
