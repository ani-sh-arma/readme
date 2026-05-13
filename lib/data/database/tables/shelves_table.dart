import 'package:drift/drift.dart';

class Shelves extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get dirPath => text().unique()();
  IntColumn get parentShelfId => integer().nullable().references(Shelves, #id)();
  BoolColumn get scanRecursive =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isRoot => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastScannedAt => dateTime().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
}
