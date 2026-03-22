import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travelfoodapp/main.dart';

void main() {
  testWidgets('App launches and shows splash screen content', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelFoodApp());

    expect(find.text('Travel Food Recommendation'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Select Your Preferences'), findsOneWidget);
  });
}