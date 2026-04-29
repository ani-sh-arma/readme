import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/book_settings_table.dart';

part 'book_settings_dao.g.dart';

@DriftAccessor(tables: [BookSettings])
class BookSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$BookSettingsDaoMixin {
  BookSettingsDao(super.db);

  Future<BookSetting?> getSettingsForBook(int bookId) =>
      (select(bookSettings)..where((s) => s.bookId.equals(bookId)))
          .getSingleOrNull();

  Stream<BookSetting?> watchSettingsForBook(int bookId) =>
      (select(bookSettings)..where((s) => s.bookId.equals(bookId)))
          .watchSingleOrNull();

  Future<void> upsertSettings(BookSettingsCompanion settings) =>
      into(bookSettings).insertOnConflictUpdate(settings);

  Future<int> deleteSettingsForBook(int bookId) =>
      (delete(bookSettings)..where((s) => s.bookId.equals(bookId))).go();
}
