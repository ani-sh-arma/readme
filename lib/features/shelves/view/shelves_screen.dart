import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/database/app_database.dart';
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
          appBar: AppBar(title: const Text('Shelves')),
          body: state.isLoading && state.shelves.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : state.rootShelves.isEmpty
              ? _EmptyState(onAdd: () => _pickDirectory(context))
              : ListView.builder(
                  itemCount: state.rootShelves.length,
                  itemBuilder: (ctx, i) {
                    final shelf = state.rootShelves[i];
                    return _ShelfTile(
                      shelf: shelf,
                      children: state.childrenOf(shelf.id),
                      onCreateSub: () =>
                          _createSubDirectory(context, shelf.dirPath),
                      onDelete: () =>
                          context.read<ShelvesCubit>().removeShelf(shelf.id),
                    );
                  },
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

class _ShelfTile extends StatelessWidget {
  const _ShelfTile({
    required this.shelf,
    required this.children,
    required this.onCreateSub,
    required this.onDelete,
  });

  final Shelf shelf;
  final List<Shelf> children;
  final VoidCallback onCreateSub;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.folder_outlined),
      title: Text(shelf.name),
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
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Remove shelf',
            onPressed: onDelete,
          ),
        ],
      ),
      children: children
          .map(
            (child) => ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: Text(child.name),
              subtitle: Text(
                child.dirPath,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: const EdgeInsets.only(left: 32, right: 16),
            ),
          )
          .toList(),
    );
  }
}
