import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/views/login_page.dart';

void main() {
  testWidgets('Login screen has a text field and login button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Entering text updates the text field', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    await tester.enterText(find.byType(TextField), 'testuser');
    await tester.pump();

    expect(find.text('testuser'), findsOneWidget);
  });
}
