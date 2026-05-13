// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelves_dao.dart';

// ignore_for_file: type=lint
mixin _$ShelvesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ShelvesTable get shelves => attachedDatabase.shelves;
  ShelvesDaoManager get managers => ShelvesDaoManager(this);
}

class ShelvesDaoManager {
  final _$ShelvesDaoMixin _db;
  ShelvesDaoManager(this._db);
  $$ShelvesTableTableManager get shelves =>
      $$ShelvesTableTableManager(_db.attachedDatabase, _db.shelves);
}
