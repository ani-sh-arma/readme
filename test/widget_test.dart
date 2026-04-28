import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:readme/main.dart';

void main() {
  testWidgets('ReadMe app shell shows the library landing page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ReadMeApp());

    expect(find.text('ReadMe'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      find.text('Scanned books, sort and filter controls, and local shelves.'),
      findsOneWidget,
    );
  });
}
