import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'daos/book_settings_dao.dart';
import 'daos/bookmarks_dao.dart';
import 'daos/books_dao.dart';
import 'daos/reading_sessions_dao.dart';
import 'daos/shelves_dao.dart';
import 'tables/book_settings_table.dart';
import 'tables/bookmarks_table.dart';
import 'tables/books_table.dart';
import 'tables/reading_sessions_table.dart';
import 'tables/shelves_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Books, Shelves, Bookmarks, BookSettings, ReadingSessions],
  daos: [
    BooksDao,
    ShelvesDao,
    BookmarksDao,
    BookSettingsDao,
    ReadingSessionsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Future migrations go here.
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
