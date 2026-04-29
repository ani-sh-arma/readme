import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'data/database/app_database.dart';
import 'data/repositories/book_repository.dart';
import 'data/repositories/bookmark_repository.dart';
import 'data/repositories/shelf_repository.dart';
import 'features/collections/view/collections_screen.dart';
import 'features/library/bloc/library_bloc.dart';
import 'features/library/view/library_screen.dart';
import 'features/settings/bloc/settings_cubit.dart';
import 'features/settings/view/settings_screen.dart';
import 'features/shelves/bloc/shelves_cubit.dart';
import 'features/shelves/view/shelves_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(ReadMeApp(db: db));
}

class ReadMeApp extends StatelessWidget {
  const ReadMeApp({super.key, required this.db});

  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    final bookRepo = BookRepository(db);
    final shelfRepo = ShelfRepository(db);
    final bookmarkRepo = BookmarkRepository(db);
    final bookSettingsRepo = BookSettingsRepository(db);
    final readingSessionRepo = ReadingSessionRepository(db);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: bookRepo),
        RepositoryProvider.value(value: shelfRepo),
        RepositoryProvider.value(value: bookmarkRepo),
        RepositoryProvider.value(value: bookSettingsRepo),
        RepositoryProvider.value(value: readingSessionRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppShellCubit()),
          BlocProvider(create: (_) => SettingsCubit()),
          BlocProvider(create: (_) => LibraryBloc(bookRepo)),
          BlocProvider(
            create: (_) => ShelvesCubit(shelfRepo, bookRepo),
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ReadMe',
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: settings.themeMode,
              home: const AppShell(),
            );
          },
        ),
      ),
    );
  }
}

enum AppTab { library, shelves, collections, settings }

class AppShellState extends Equatable {
  const AppShellState({this.selectedTab = AppTab.library});

  final AppTab selectedTab;

  AppShellState copyWith({AppTab? selectedTab}) {
    return AppShellState(selectedTab: selectedTab ?? this.selectedTab);
  }

  @override
  List<Object?> get props => [selectedTab];
}

class AppShellCubit extends Cubit<AppShellState> {
  AppShellCubit() : super(const AppShellState());

  void selectTab(AppTab tab) => emit(state.copyWith(selectedTab: tab));
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppShellCubit, AppShellState>(
      builder: (context, state) {
        final pages = <Widget>[
          const LibraryScreen(),
          const ShelvesScreen(),
          const CollectionsScreen(),
          const SettingsScreen(),
        ];

        return Scaffold(
          body: SafeArea(child: pages[state.selectedTab.index]),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.selectedTab.index,
            onDestinationSelected: (index) {
              context.read<AppShellCubit>().selectTab(AppTab.values[index]);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.local_library_outlined),
                selectedIcon: Icon(Icons.local_library),
                label: 'Library',
              ),
              NavigationDestination(
                icon: Icon(Icons.folder_outlined),
                selectedIcon: Icon(Icons.folder),
                label: 'Shelves',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmarks_outlined),
                selectedIcon: Icon(Icons.bookmarks),
                label: 'Collections',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

