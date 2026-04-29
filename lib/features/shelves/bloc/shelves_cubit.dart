import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/tables/shelves_table.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/shelf_repository.dart';
import 'shelves_bloc.dart';

class ShelvesCubit extends Cubit<ShelvesState> {
  ShelvesCubit(this._shelfRepo, this._bookRepo) : super(const ShelvesState());

  final ShelfRepository _shelfRepo;
  final BookRepository _bookRepo;
  StreamSubscription<dynamic>? _sub;
  final Map<String, StreamSubscription<FileSystemEvent>> _directoryWatchers =
      {};
  final Map<String, Future<void>> _watcherQueues = {};

  Future<void> start() async {
    emit(state.copyWith(isLoading: true));
    await _sub?.cancel();
    _sub = _shelfRepo.watchAllShelves().listen(
      (shelves) {
        _syncDirectoryWatchers(shelves);
        emit(state.copyWith(shelves: shelves, isLoading: false));
      },
    );
  }

  Future<void> addDirectory(Directory dir) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _shelfRepo.registerDirectoryTree(dir);
      await _bookRepo.scanDirectory(dir);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> removeShelf(int id) async {
    await _shelfRepo.removeShelf(id);
  }

  Future<void> createSubDirectory(String parentPath, String name) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _shelfRepo.createDirectory(parentPath, name);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    for (final sub in _directoryWatchers.values) {
      sub.cancel();
    }
    _directoryWatchers.clear();
    _watcherQueues.clear();
    return super.close();
  }

  void _syncDirectoryWatchers(List<Shelf> shelves) {
    final currentPaths = shelves.map((shelf) => shelf.dirPath).toSet();

    final stalePaths =
        _directoryWatchers.keys.where((p) => !currentPaths.contains(p)).toList();
    for (final path in stalePaths) {
      _directoryWatchers[path]?.cancel();
      _directoryWatchers.remove(path);
      _watcherQueues.remove(path);
    }

    for (final shelf in shelves) {
      final path = shelf.dirPath;
      if (_directoryWatchers.containsKey(path)) continue;
      _watchShelf(shelf);
    }
  }

  void _watchShelf(Shelf shelf) {
    final dir = Directory(shelf.dirPath);
    if (!dir.existsSync()) return;

    final sub = dir.watch(recursive: shelf.scanRecursive).listen((event) async {
      if (event.isDirectory) return;
      _enqueueWatcherWork(shelf.dirPath, () async {
        if (event.type == FileSystemEvent.delete) {
          await _bookRepo.removeBookByPath(event.path);
          return;
        }

        if (event.type == FileSystemEvent.create ||
            event.type == FileSystemEvent.modify ||
            event.type == FileSystemEvent.move) {
          await _bookRepo.upsertFromFile(File(event.path));
        }
      });
    });

    _directoryWatchers[shelf.dirPath] = sub;
  }

  void _enqueueWatcherWork(
    String path,
    Future<void> Function() action,
  ) {
    final queue = _watcherQueues[path] ?? Future.value();
    _watcherQueues[path] = queue.then((_) => action()).catchError((error, _) {
      debugPrint('Directory watch error for $path: $error');
    });
  }
}
