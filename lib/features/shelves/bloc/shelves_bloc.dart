import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../data/database/app_database.dart';

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
    this.syncingPath,
  });

  final List<Shelf> shelves;
  final bool isLoading;
  final String? error;
  final String? syncingPath;

  /// Returns root shelves (no parent).
  List<Shelf> get rootShelves =>
      shelves.where((s) => s.parentShelfId == null).toList();

  List<Shelf> childrenOf(int parentId) =>
      shelves.where((s) => s.parentShelfId == parentId).toList();

  ShelvesState copyWith({
    List<Shelf>? shelves,
    bool? isLoading,
    String? error,
    String? syncingPath,
    bool clearError = false,
    bool clearSyncingPath = false,
  }) {
    return ShelvesState(
      shelves: shelves ?? this.shelves,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      syncingPath: clearSyncingPath ? null : (syncingPath ?? this.syncingPath),
    );
  }

  @override
  List<Object?> get props => [shelves, isLoading, error, syncingPath];
}
