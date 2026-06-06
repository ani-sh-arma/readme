import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';

class SortFilterBar extends StatelessWidget {
  const SortFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LibraryBloc>();

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              // Sort dropdown
              _SortButton(state: state, bloc: bloc),
              const SizedBox(width: 8),
              // Format filter chips
              _FilterChip(
                label: 'EPUB',
                selected: state.formatFilter == 'epub',
                onSelected: (v) =>
                    bloc.add(LibraryFormatFilterChanged(v ? 'epub' : null)),
              ),
              const SizedBox(width: 4),
              _FilterChip(
                label: 'PDF',
                selected: state.formatFilter == 'pdf',
                onSelected: (v) =>
                    bloc.add(LibraryFormatFilterChanged(v ? 'pdf' : null)),
              ),
              const SizedBox(width: 8),
              // Status filter chips
              _FilterChip(
                label: 'Unread',
                selected: state.statusFilter == 'unread',
                onSelected: (v) =>
                    bloc.add(LibraryStatusFilterChanged(v ? 'unread' : null)),
              ),
              const SizedBox(width: 4),
              _FilterChip(
                label: 'Reading',
                selected: state.statusFilter == 'reading',
                onSelected: (v) =>
                    bloc.add(LibraryStatusFilterChanged(v ? 'reading' : null)),
              ),
              const SizedBox(width: 4),
              _FilterChip(
                label: 'Read',
                selected: state.statusFilter == 'read',
                onSelected: (v) =>
                    bloc.add(LibraryStatusFilterChanged(v ? 'read' : null)),
              ),
              const SizedBox(width: 8),
              // Favorites
              _FilterChip(
                label: 'Favourites',
                selected: state.favoritesOnly,
                onSelected: (_) => bloc.add(LibraryFavoritesFilterToggled()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.state, required this.bloc});

  final LibraryState state;
  final LibraryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LibrarySortField>(
      initialValue: state.sortField,
      onSelected: (field) {
        final asc = field == state.sortField ? !state.ascending : true;
        bloc.add(LibrarySortChanged(field, ascending: asc));
      },
      itemBuilder: (_) => [
        for (final field in LibrarySortField.values)
          PopupMenuItem(
            value: field,
            child: Row(
              children: [
                if (state.sortField == field)
                  Icon(
                    state.ascending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 16,
                  )
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Text(_labelForField(field)),
              ],
            ),
          ),
      ],
      child: Chip(
        avatar: const Icon(Icons.sort, size: 16),
        label: Text(_labelForField(state.sortField)),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  String _labelForField(LibrarySortField field) {
    switch (field) {
      case LibrarySortField.title:
        return 'Title';
      case LibrarySortField.author:
        return 'Author';
      case LibrarySortField.dateAdded:
        return 'Date Added';
      case LibrarySortField.lastRead:
        return 'Last Read';
      case LibrarySortField.fileSize:
        return 'File Size';
      case LibrarySortField.format:
        return 'Format';
    }
  }
}
