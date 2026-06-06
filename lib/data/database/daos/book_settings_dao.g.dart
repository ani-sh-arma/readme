// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_settings_dao.dart';

// ignore_for_file: type=lint
mixin _$BookSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $BooksTable get books => attachedDatabase.books;
  $BookSettingsTable get bookSettings => attachedDatabase.bookSettings;
  BookSettingsDaoManager get managers => BookSettingsDaoManager(this);
}

class BookSettingsDaoManager {
  final _$BookSettingsDaoMixin _db;
  BookSettingsDaoManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db.attachedDatabase, _db.books);
  $$BookSettingsTableTableManager get bookSettings =>
      $$BookSettingsTableTableManager(_db.attachedDatabase, _db.bookSettings);
}
