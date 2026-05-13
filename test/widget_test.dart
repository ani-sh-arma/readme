import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:readme/main.dart';
import 'package:readme/features/settings/bloc/settings_cubit.dart';

void main() {
  testWidgets('App shell renders bottom navigation', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppShellCubit()..selectTab(AppTab.settings),
          ),
          BlocProvider(create: (_) => SettingsCubit()),
        ],
        child: const MaterialApp(home: AppShell()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Library'), findsWidgets);
    expect(find.text('Shelves'), findsWidgets);
    expect(find.text('Settings'), findsWidgets);
  });
}
