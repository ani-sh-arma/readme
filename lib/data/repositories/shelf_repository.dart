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
  }) {
    final name = p.basename(dirPath);
    return _db.shelvesDao.insertShelf(
      ShelvesCompanion(
        name: Value(name),
        dirPath: Value(dirPath),
        parentShelfId: Value(parentId),
        scanRecursive: Value(scanRecursive),
      ),
    );
  }

  /// Registers [dir] and all its direct sub-directories as shelves in the DB.
  Future<void> registerDirectoryTree(Directory dir) async {
    await addShelf(dir.path);
    await for (final entity in dir.list(recursive: false)) {
      if (entity is Directory) {
        final shelf = await _db.shelvesDao.getShelfByPath(dir.path);
        await addShelf(entity.path, parentId: shelf?.id);
      }
    }
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
    await addShelf(newDir.path, parentId: parent?.id);
    return _db.shelvesDao.getShelfByPath(newDir.path);
  }
}
