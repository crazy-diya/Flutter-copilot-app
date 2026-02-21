import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_copilot_app/main.dart';

void main() {
  testWidgets('SplashScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.flutter_dash), findsOneWidget);
    expect(find.text('Flutter Widget Showcase'), findsOneWidget);
  });
}
