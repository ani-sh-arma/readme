import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../database/app_database.dart';

class ShelfRepository {
  const ShelfRepository(this._db);

  final AppDatabase _db;

  Stream<List<Shelf>> watchAllShelves() => _db.shelvesDao.watchAllShelves();

  Future<List<Shelf>> getAllShelves() => _db.shelvesDao.getAllShelves();

  Future<List<Shelf>> getRootShelves() => _db.shelvesDao.getRootShelves();

  Future<List<Shelf>> getChildShelves(int parentId) =>
      _db.shelvesDao.getChildShelves(parentId);

  Future<int> addShelf(
    String dirPath, {
    int? parentId,
    bool scanRecursive = true,
    bool isRoot = false,
    int displayOrder = 0,
  }) {
    final name = p.basename(dirPath);
    return _upsertShelf(
      dirPath,
      name: name,
      parentId: parentId,
      scanRecursive: scanRecursive,
      isRoot: isRoot,
      displayOrder: displayOrder,
    );
  }

  Future<void> registerDirectoryTree(
    Directory dir, {
    bool scanRecursive = true,
  }) async {
    final visitedPaths = <String>{};
    final rootId = await addShelf(
      dir.path,
      isRoot: true,
      scanRecursive: scanRecursive,
    );
    visitedPaths.add(dir.path);
    await _registerChildrenRecursive(
      dir,
      parentId: rootId,
      scanRecursive: scanRecursive,
      visitedPaths: visitedPaths,
    );
    await _removeStaleShelves(dir.path, visitedPaths);
  }

  Future<int> removeShelf(int id) => _db.shelvesDao.deleteShelf(id);

  Future<int> removeShelfByPath(String path) =>
      _db.shelvesDao.deleteShelfByPath(path);

  /// Creates a new directory on-disk and registers it as a shelf child of [parentPath].
  Future<Shelf?> createDirectory(String parentPath, String name) async {
    final newDir = Directory(p.join(parentPath, name));
    if (!newDir.existsSync()) {
      await newDir.create(recursive: true);
    }
    final parent = await _db.shelvesDao.getShelfByPath(parentPath);
    await addShelf(
      newDir.path,
      parentId: parent?.id,
      scanRecursive: parent?.scanRecursive ?? true,
    );
    return _db.shelvesDao.getShelfByPath(newDir.path);
  }

  Future<void> updateScanRecursive(int id, bool recursive) async {
    await _db.shelvesDao.updateScanRecursive(id, recursive);
  }

  Future<void> _registerChildrenRecursive(
    Directory dir, {
    required int parentId,
    required bool scanRecursive,
    required Set<String> visitedPaths,
  }) async {
    final children =
        await dir.list(recursive: false, followLinks: false).toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    var displayOrder = 0;
    for (final entity in children) {
      if (entity is! Directory) continue;
      final childId = await addShelf(
        entity.path,
        parentId: parentId,
        scanRecursive: scanRecursive,
        displayOrder: displayOrder++,
      );
      visitedPaths.add(entity.path);
      await _registerChildrenRecursive(
        entity,
        parentId: childId,
        scanRecursive: scanRecursive,
        visitedPaths: visitedPaths,
      );
    }
  }

  Future<void> _removeStaleShelves(
    String rootPath,
    Set<String> visitedPaths,
  ) async {
    final shelves = await getAllShelves();
    for (final shelf in shelves) {
      if (!_isInRoot(shelf.dirPath, rootPath)) continue;
      if (!visitedPaths.contains(shelf.dirPath)) {
        await removeShelf(shelf.id);
      }
    }
  }

  bool _isInRoot(String candidate, String rootPath) {
    final normalizedCandidate = candidate.replaceAll('\\', '/');
    final normalizedRoot = rootPath.replaceAll('\\', '/');
    return normalizedCandidate == normalizedRoot ||
        normalizedCandidate.startsWith('$normalizedRoot/');
  }

  Future<int> _upsertShelf(
    String dirPath, {
    required String name,
    required int? parentId,
    required bool scanRecursive,
    required bool isRoot,
    required int displayOrder,
  }) async {
    await _db.shelvesDao.insertShelf(
      ShelvesCompanion(
        name: Value(name),
        dirPath: Value(dirPath),
        parentShelfId: Value(parentId),
        scanRecursive: Value(scanRecursive),
        isRoot: Value(isRoot),
        lastScannedAt: Value(DateTime.now()),
        displayOrder: Value(displayOrder),
      ),
    );
    final saved = await _db.shelvesDao.getShelfByPath(dirPath);
    if (saved == null) {
      throw StateError('Failed to save shelf for $dirPath');
    }
    return saved.id;
  }
}
