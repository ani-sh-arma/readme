import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/shelf_repository.dart';
import 'shelves_bloc.dart';

class ShelvesCubit extends Cubit<ShelvesState> {
  ShelvesCubit(this._shelfRepo, this._bookRepo) : super(const ShelvesState());

  final ShelfRepository _shelfRepo;
  final BookRepository _bookRepo;
  StreamSubscription<List<Shelf>>? _sub;
  final Map<String, StreamSubscription<FileSystemEvent>> _directoryWatchers =
      {};
  final Map<String, Future<void>> _watcherQueues = {};
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _sub?.cancel();
    _sub = _shelfRepo.watchAllShelves().listen((shelves) {
      _syncDirectoryWatchers(shelves);
      emit(state.copyWith(shelves: shelves, isLoading: false));
    });
    await syncAllRoots();
  }

  Future<void> syncAllRoots() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final roots = await _shelfRepo.getRootShelves();
      for (final root in roots) {
        await _syncRoot(root);
      }
      emit(state.copyWith(isLoading: false, clearSyncingPath: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          clearSyncingPath: true,
        ),
      );
    }
  }

  Future<void> addDirectory(Directory dir) async {
    emit(state.copyWith(isLoading: true, syncingPath: dir.path));
    try {
      await _shelfRepo.registerDirectoryTree(dir);
      await _bookRepo.scanDirectory(dir);
      emit(state.copyWith(isLoading: false, clearSyncingPath: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          clearSyncingPath: true,
        ),
      );
    }
  }

  Future<void> removeShelf(int id) async {
    await _shelfRepo.removeShelf(id);
  }

  Future<void> createSubDirectory(String parentPath, String name) async {
    emit(state.copyWith(isLoading: true, syncingPath: parentPath));
    try {
      await _shelfRepo.createDirectory(parentPath, name);
      final root = _rootForPath(parentPath);
      if (root != null) {
        await _syncRoot(root);
      }
      emit(state.copyWith(isLoading: false, clearSyncingPath: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          clearSyncingPath: true,
        ),
      );
    }
  }

  Future<void> updateScanRecursive(Shelf shelf, bool recursive) async {
    await _shelfRepo.updateScanRecursive(shelf.id, recursive);
    await _shelfRepo.registerDirectoryTree(
      Directory(shelf.dirPath),
      scanRecursive: recursive,
    );
    await _bookRepo.scanDirectory(
      Directory(shelf.dirPath),
      recursive: recursive,
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    for (final sub in _directoryWatchers.values) {
      await sub.cancel();
    }
    _directoryWatchers.clear();
    _watcherQueues.clear();
    return super.close();
  }

  void _syncDirectoryWatchers(List<Shelf> shelves) {
    final roots = shelves
        .where((shelf) => shelf.parentShelfId == null)
        .toList();
    final currentPaths = roots.map((shelf) => shelf.dirPath).toSet();

    final stalePaths = _directoryWatchers.keys
        .where((path) => !currentPaths.contains(path))
        .toList();
    for (final path in stalePaths) {
      _directoryWatchers[path]?.cancel();
      _directoryWatchers.remove(path);
      _watcherQueues.remove(path);
    }

    for (final root in roots) {
      if (_directoryWatchers.containsKey(root.dirPath)) continue;
      _watchRoot(root);
    }
  }

  void _watchRoot(Shelf root) {
    final dir = Directory(root.dirPath);
    if (!dir.existsSync()) return;

    final sub = dir.watch(recursive: root.scanRecursive).listen((event) {
      _enqueueWatcherWork(root.dirPath, () async {
        if (event.isDirectory || event.type == FileSystemEvent.move) {
          await _syncRoot(root);
          return;
        }

        if (event.type == FileSystemEvent.delete) {
          await _bookRepo.removeBookByPath(event.path);
          return;
        }

        if (event.type == FileSystemEvent.create ||
            event.type == FileSystemEvent.modify) {
          final file = File(event.path);
          if (!file.existsSync()) {
            await _syncRoot(root);
            return;
          }
          await _bookRepo.upsertFromFile(file);
        }
      });
    });

    _directoryWatchers[root.dirPath] = sub;
  }

  void _enqueueWatcherWork(String path, Future<void> Function() action) {
    final queue = _watcherQueues[path] ?? Future.value();
    _watcherQueues[path] = queue.then((_) => action()).catchError((
      error,
      stackTrace,
    ) {
      debugPrint('Directory watch error for $path: $error\n$stackTrace');
    });
  }

  Future<void> _syncRoot(Shelf root) async {
    final directory = Directory(root.dirPath);
    emit(state.copyWith(syncingPath: root.dirPath));
    if (!directory.existsSync()) {
      await _shelfRepo.removeShelf(root.id);
      emit(state.copyWith(clearSyncingPath: true));
      return;
    }

    await _shelfRepo.registerDirectoryTree(
      directory,
      scanRecursive: root.scanRecursive,
    );
    await _bookRepo.scanDirectory(directory, recursive: root.scanRecursive);
    emit(state.copyWith(clearSyncingPath: true));
  }

  Shelf? _rootForPath(String path) {
    final normalized = path.replaceAll('\\', '/');
    for (final shelf in state.rootShelves) {
      final root = shelf.dirPath.replaceAll('\\', '/');
      if (normalized == root || normalized.startsWith('$root/')) {
        return shelf;
      }
    }
    return null;
  }
}
