import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/database/app_database.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/book_items.dart';
import '../widgets/sort_filter_bar.dart';
import '../../reader/view/reader_screen.dart';
import '../../shelves/bloc/shelves_cubit.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _searchController = TextEditingController();
  bool _searchVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(LibraryStarted());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _searchVisible = !_searchVisible;
      if (!_searchVisible) {
        _searchController.clear();
        context.read<LibraryBloc>().add(LibrarySearchChanged(''));
      }
    });
  }

  Future<void> _pickDirectory(BuildContext context) async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        final fallback = await Permission.storage.request();
        if (!fallback.isGranted && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Storage permission denied')),
          );
          return;
        }
      }
    }

    final path = await FilePicker.getDirectoryPath();
    if (path != null && context.mounted) {
      final directory = Directory(path);
      context.read<LibraryBloc>().add(LibraryScanRequested(directory));
      await context.read<ShelvesCubit>().addDirectory(directory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Library'),
            actions: [
              IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () =>
                    context.read<LibraryBloc>().add(LibrarySyncRequested()),
                tooltip: 'Sync library',
              ),
              IconButton(
                icon: Icon(_searchVisible ? Icons.close : Icons.search),
                onPressed: _toggleSearch,
                tooltip: _searchVisible ? 'Close search' : 'Search',
              ),
              IconButton(
                icon: Icon(
                  state.viewMode == LibraryViewMode.grid
                      ? Icons.view_list_outlined
                      : Icons.grid_view_outlined,
                ),
                onPressed: () =>
                    context.read<LibraryBloc>().add(LibraryViewModeToggled()),
                tooltip: 'Toggle view',
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(_searchVisible ? 108 : 48),
              child: Column(
                children: [
                  if (_searchVisible)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: SearchBar(
                        controller: _searchController,
                        hintText: 'Search books…',
                        leading: const Icon(Icons.search),
                        autoFocus: true,
                        trailing: [
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<LibraryBloc>().add(
                                  LibrarySearchChanged(''),
                                );
                                setState(() {});
                              },
                            ),
                        ],
                        onChanged: (v) {
                          context.read<LibraryBloc>().add(
                            LibrarySearchChanged(v),
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  const SortFilterBar(),
                ],
              ),
            ),
          ),
          body: _buildBody(context, state),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _pickDirectory(context),
            icon: const Icon(Icons.create_new_folder_outlined),
            label: const Text('Add library root'),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, LibraryState state) {
    if (state.scanProgress != null) {
      return Column(
        children: [
          const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Scanning: ${state.scanProgress}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    if (state.isLoading && state.books.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final books = state.filteredBooks;

    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_library_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              state.books.isEmpty
                  ? 'No books yet.\nTap + to add a library folder.'
                  : 'No books match the current filter.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.viewMode == LibraryViewMode.grid) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<LibraryBloc>().add(LibrarySyncRequested());
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.62,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: books.length,
          itemBuilder: (ctx, i) => BookGridItem(
            book: books[i],
            onTap: () => _openBook(context, books[i]),
            onLongPress: () => _showBookMenu(context, books[i]),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<LibraryBloc>().add(LibrarySyncRequested());
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: books.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (ctx, i) => BookListItem(
          book: books[i],
          onTap: () => _openBook(context, books[i]),
          onLongPress: () => _showBookMenu(context, books[i]),
        ),
      ),
    );
  }

  void _openBook(BuildContext context, Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReaderScreen(book: book),
        fullscreenDialog: true,
      ),
    );
  }

  void _showBookMenu(BuildContext context, Book book) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => _BookMenuSheet(book: book),
    );
  }
}

class _BookMenuSheet extends StatelessWidget {
  const _BookMenuSheet({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: Text(
              book.isFavorite ? 'Remove from favourites' : 'Add to favourites',
            ),
            onTap: () {
              context.read<LibraryBloc>().add(
                LibraryBookFavoriteToggled(
                  book.id,
                  isFavorite: !book.isFavorite,
                ),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: Text(book.isRead ? 'Mark as unread' : 'Mark as read'),
            onTap: () {
              context.read<LibraryBloc>().add(
                LibraryBookReadToggled(book.id, isRead: !book.isRead),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Remove from library'),
            onTap: () {
              context.read<LibraryBloc>().add(LibraryBookDeleted(book.id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
