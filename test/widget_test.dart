import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:readme/main.dart';

void main() {
  testWidgets('App shell renders bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => AppShellCubit(),
        child: const MaterialApp(home: AppShell()),
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Library'), findsWidgets);
    expect(find.text('Shelves'), findsWidgets);
  });
}
