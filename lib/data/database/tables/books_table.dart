import 'package:drift/drift.dart';

/// Supported ebook/document formats.
enum BookFormat { epub, pdf, txt, html, cbz, cbr, mobi, azw, azw3, djvu, unknown }

class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text().withDefault(const Constant('Unknown'))();
  TextColumn get filePath => text()();
  TextColumn get coverPath => text().nullable()();
  TextColumn get coverSource =>
      text().withDefault(const Constant('generated'))();
  TextColumn get format =>
      text().withDefault(const Constant('unknown'))(); // BookFormat name
  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();
  IntColumn get totalPages => integer().withDefault(const Constant(0))();
  TextColumn get currentPosition =>
      text().withDefault(const Constant(''))(); // page index or CFI string
  RealColumn get lastReadProgress =>
      real().withDefault(const Constant(0.0))(); // 0..1
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isInReadList =>
      boolean().withDefault(const Constant(false))();
  RealColumn get rating => real().nullable()();
  IntColumn get fileSize => integer().withDefault(const Constant(0))();
  TextColumn get genre => text().nullable()();
}
