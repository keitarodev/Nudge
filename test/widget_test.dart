import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nudge/main.dart';

void main() {
  testWidgets('Create tab opens Create Nudge flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(find.text('Create Nudge'), findsOneWidget);

    expect(find.text('What should we remind you?'), findsOneWidget);

    expect(find.text('Step 1 of 4'), findsOneWidget);
  });
}
