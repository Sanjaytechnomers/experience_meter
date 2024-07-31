import 'package:experience_meter/experience_meter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MeterPainter paints correctly', (WidgetTester tester) async {
    // Create a widget to test
    final testWidget = SizedBox(
      width: 300,
      height: 150,
      child: CustomPaint(
        key: const Key('meter_painter'),
        painter: ExperienceMeter(value: 50, centerText: '50'),
      ),
    );

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: testWidget)));

    // Perform tests
    final Finder finder = find.byKey(const Key('meter_painter'));
    expect(finder, findsOneWidget);

    // Add more tests as needed
  });
}
