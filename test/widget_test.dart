import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('BMI Calculation test', (WidgetTester tester) async {
    await tester.pumpWidget(const BMICalculatorApp());

    // Enter height and weight
    await tester.enterText(find.byType(TextField).at(0), '170');
    await tester.enterText(find.byType(TextField).at(1), '65');

    // Tap calculate button
    await tester.tap(find.text('Calculate'));
    await tester.pump();

    // Check if BMI result appears
    expect(find.textContaining('Your BMI is:'), findsOneWidget);
    expect(find.textContaining('Status:'), findsOneWidget);
  });
}
