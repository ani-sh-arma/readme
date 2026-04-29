import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../data/database/tables/shelves_table.dart';

// --- Events ---

abstract class ShelvesEvent {}

class ShelvesStarted extends ShelvesEvent {}

class ShelvesUpdated extends ShelvesEvent {
  ShelvesUpdated(this.shelves);
  final List<Shelf> shelves;
}

class ShelvesDirectoryAdded extends ShelvesEvent {
  ShelvesDirectoryAdded(this.directory);
  final Directory directory;
}

class ShelvesDirectoryRemoved extends ShelvesEvent {
  ShelvesDirectoryRemoved(this.shelfId);
  final int shelfId;
}

class ShelvesNewDirectoryCreated extends ShelvesEvent {
  ShelvesNewDirectoryCreated(this.parentPath, this.name);
  final String parentPath;
  final String name;
}

// --- State ---

class ShelvesState extends Equatable {
  const ShelvesState({
    this.shelves = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Shelf> shelves;
  final bool isLoading;
  final String? error;

  /// Returns root shelves (no parent).
  List<Shelf> get rootShelves =>
      shelves.where((s) => s.parentShelfId == null).toList();

  List<Shelf> childrenOf(int parentId) =>
      shelves.where((s) => s.parentShelfId == parentId).toList();

  ShelvesState copyWith({
    List<Shelf>? shelves,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return ShelvesState(
      shelves: shelves ?? this.shelves,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [shelves, isLoading, error];
}
