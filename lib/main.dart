import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ReadMeApp());
}

class ReadMeApp extends StatelessWidget {
  const ReadMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppShellCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ReadMe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E5A6B),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF89B4C9),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const AppShell(),
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
          const _HomePlaceholder(
            title: 'Library',
            subtitle:
                'Scanned books, sort and filter controls, and local shelves.',
          ),
          const _HomePlaceholder(
            title: 'Shelves',
            subtitle: 'Filesystem-backed directory tree and recursive scans.',
          ),
          const _HomePlaceholder(
            title: 'Collections',
            subtitle:
                'Reading, read, favourites, bookmarks, and history views.',
          ),
          const _HomePlaceholder(
            title: 'Settings',
            subtitle: 'Themes, reader defaults, storage, and platform options.',
          ),
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
                label: 'Library',
              ),
              NavigationDestination(
                icon: Icon(Icons.folder_outlined),
                label: 'Shelves',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmarks_outlined),
                label: 'Collections',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ReadMe',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(subtitle, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.create_new_folder_outlined),
                label: const Text('Add library root'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
