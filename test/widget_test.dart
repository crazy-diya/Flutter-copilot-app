import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_copilot_app/main.dart';
import 'package:flutter_copilot_app/home_screen.dart';

void main() {
  testWidgets('SplashScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
    expect(find.text('Flutter Copilot App'), findsOneWidget);
  });

  testWidgets('HomeScreen displays Hello World', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text('Hello, World!'), findsOneWidget);
  });
}
