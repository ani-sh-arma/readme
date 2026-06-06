import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'daos/book_settings_dao.dart';
import 'daos/bookmarks_dao.dart';
import 'daos/books_dao.dart';
import 'daos/highlights_dao.dart';
import 'daos/reading_sessions_dao.dart';
import 'daos/shelves_dao.dart';
import 'tables/book_settings_table.dart';
import 'tables/bookmarks_table.dart';
import 'tables/books_table.dart';
import 'tables/highlights_table.dart';
import 'tables/reading_sessions_table.dart';
import 'tables/shelves_table.dart';

part 'app_database.g.dart';

typedef Shelf = Shelve;

@DriftDatabase(
  tables: [
    Books,
    Shelves,
    Bookmarks,
    BookSettings,
    ReadingSessions,
    Highlights,
  ],
  daos: [
    BooksDao,
    ShelvesDao,
    BookmarksDao,
    BookSettingsDao,
    ReadingSessionsDao,
    HighlightsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(books, books.coverSource);
        await m.addColumn(books, books.lastReadProgress);
        await m.addColumn(shelves, shelves.isRoot);
        await m.addColumn(shelves, shelves.lastScannedAt);
        await m.addColumn(shelves, shelves.displayOrder);
        await m.addColumn(bookSettings, bookSettings.autoScrollEnabled);
        await m.addColumn(bookSettings, bookSettings.autoScrollSpeed);
        await m.addColumn(bookSettings, bookSettings.sleepTimerMinutes);
        await m.addColumn(bookSettings, bookSettings.readingDirection);
        await m.addColumn(bookSettings, bookSettings.doublePageSpread);
        await m.createTable(highlights);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'readme.sqlite'));

    final cacheBase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cacheBase.path;

    return NativeDatabase.createInBackground(file);
  });
}
