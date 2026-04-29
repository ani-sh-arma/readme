import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/database/tables/books_table.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/book_items.dart';
import '../widgets/sort_filter_bar.dart';
import '../../reader/view/reader_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _searchController = TextEditingController();

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

    final path = await FilePicker.platform.getDirectoryPath();
    if (path != null && context.mounted) {
      context
          .read<LibraryBloc>()
          .add(LibraryScanRequested(Directory(path)));
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
              preferredSize: const Size.fromHeight(96),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: SearchBar(
                      controller: _searchController,
                      hintText: 'Search books…',
                      leading: const Icon(Icons.search),
                      trailing: [
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<LibraryBloc>()
                                  .add(LibrarySearchChanged(''));
                            },
                          ),
                      ],
                      onChanged: (v) =>
                          context.read<LibraryBloc>().add(LibrarySearchChanged(v)),
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
          LinearProgressIndicator(),
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
          // Pull-to-refresh: re-add LibraryStarted to force stream re-listen
          context.read<LibraryBloc>().add(LibraryStarted());
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 0.6,
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
        context.read<LibraryBloc>().add(LibraryStarted());
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: books.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
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
            title:
                Text(book.isFavorite ? 'Remove from favourites' : 'Add to favourites'),
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
