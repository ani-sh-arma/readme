import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import '../../library/widgets/book_items.dart';
import '../../reader/view/reader_screen.dart';
import '../bloc/shelves_bloc.dart';
import '../bloc/shelves_cubit.dart';

class ShelvesScreen extends StatefulWidget {
  const ShelvesScreen({super.key});

  @override
  State<ShelvesScreen> createState() => _ShelvesScreenState();
}

class _ShelvesScreenState extends State<ShelvesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShelvesCubit>().start();
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
      await context.read<ShelvesCubit>().addDirectory(Directory(path));
    }
  }

  Future<void> _createSubDirectory(
    BuildContext context,
    String parentPath,
  ) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Folder name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (confirmed == true && controller.text.trim().isNotEmpty) {
      if (context.mounted) {
        await context.read<ShelvesCubit>().createSubDirectory(
          parentPath,
          controller.text.trim(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelvesCubit, ShelvesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Shelves'),
            actions: [
              IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => context.read<ShelvesCubit>().syncAllRoots(),
                tooltip: 'Sync shelves',
              ),
            ],
          ),
          body: state.isLoading && state.shelves.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : state.rootShelves.isEmpty
              ? _EmptyState(onAdd: () => _pickDirectory(context))
              : Column(
                  children: [
                    if (state.syncingPath != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Syncing ${state.syncingPath!}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.rootShelves.length,
                        itemBuilder: (ctx, i) {
                          final shelf = state.rootShelves[i];
                          return _ShelfNode(
                            shelf: shelf,
                            allShelves: state.shelves,
                            onCreateSub: () =>
                                _createSubDirectory(context, shelf.dirPath),
                            onDelete: () => context
                                .read<ShelvesCubit>()
                                .removeShelf(shelf.id),
                            onOpen: () => _openShelf(context, shelf),
                            onRecursiveChanged: (value) => context
                                .read<ShelvesCubit>()
                                .updateScanRecursive(shelf, value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _pickDirectory(context),
            icon: const Icon(Icons.add),
            label: const Text('Add folder'),
          ),
        );
      },
    );
  }

  void _openShelf(BuildContext context, Shelf shelf) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => _ShelfBooksScreen(shelf: shelf)));
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          const Text('No shelves yet.\nTap + to add a folder.'),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add folder'),
          ),
        ],
      ),
    );
  }
}

class _ShelfNode extends StatelessWidget {
  const _ShelfNode({
    required this.shelf,
    required this.allShelves,
    required this.onCreateSub,
    required this.onDelete,
    required this.onOpen,
    required this.onRecursiveChanged,
  });

  final Shelf shelf;
  final List<Shelf> allShelves;
  final VoidCallback onCreateSub;
  final VoidCallback onDelete;
  final VoidCallback onOpen;
  final ValueChanged<bool> onRecursiveChanged;

  @override
  Widget build(BuildContext context) {
    final children =
        allShelves.where((child) => child.parentShelfId == shelf.id).toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return ExpansionTile(
      leading: const Icon(Icons.folder_outlined),
      title: GestureDetector(onTap: onOpen, child: Text(shelf.name)),
      subtitle: Text(
        shelf.dirPath,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.create_new_folder_outlined),
            tooltip: 'New subfolder',
            onPressed: onCreateSub,
          ),
          if (shelf.isRoot)
            Switch(value: shelf.scanRecursive, onChanged: onRecursiveChanged),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Remove shelf',
            onPressed: onDelete,
          ),
        ],
      ),
      children: children
          .map(
            (child) => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _ShelfNode(
                shelf: child,
                allShelves: allShelves,
                onCreateSub: () {
                  final stateful = context
                      .findAncestorStateOfType<_ShelvesScreenState>();
                  stateful?._createSubDirectory(context, child.dirPath);
                },
                onDelete: () =>
                    context.read<ShelvesCubit>().removeShelf(child.id),
                onOpen: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => _ShelfBooksScreen(shelf: child),
                  ),
                ),
                onRecursiveChanged: onRecursiveChanged,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ShelfBooksScreen extends StatelessWidget {
  const _ShelfBooksScreen({required this.shelf});

  final Shelf shelf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(shelf.name)),
      body: StreamBuilder<List<Book>>(
        stream: context.read<BookRepository>().watchBooksInDirectory(
          shelf.dirPath,
          recursive: shelf.scanRecursive,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snapshot.data!;
          if (books.isEmpty) {
            return const Center(child: Text('No books in this shelf yet.'));
          }
          return ListView.separated(
            itemCount: books.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) => BookListItem(
              book: books[index],
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReaderScreen(book: books[index]),
                  fullscreenDialog: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
