import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/shelves_table.dart';

part 'shelves_dao.g.dart';

@DriftAccessor(tables: [Shelves])
class ShelvesDao extends DatabaseAccessor<AppDatabase> with _$ShelvesDaoMixin {
  ShelvesDao(super.db);

  Stream<List<Shelf>> watchAllShelves() => select(shelves).watch();

  Future<List<Shelf>> getAllShelves() => select(shelves).get();

  Future<List<Shelf>> getRootShelves() =>
      (select(shelves)..where((s) => s.parentShelfId.isNull())).get();

  Future<List<Shelf>> getChildShelves(int parentId) =>
      (select(shelves)..where((s) => s.parentShelfId.equals(parentId))).get();

  Future<Shelf?> getShelfByPath(String path) =>
      (select(shelves)..where((s) => s.dirPath.equals(path)))
          .getSingleOrNull();

  Future<int> insertShelf(ShelvesCompanion shelf) =>
      into(shelves).insertOnConflictUpdate(shelf);

  Future<int> deleteShelf(int id) =>
      (delete(shelves)..where((s) => s.id.equals(id))).go();

  Future<int> deleteShelfByPath(String path) =>
      (delete(shelves)..where((s) => s.dirPath.equals(path))).go();
}
