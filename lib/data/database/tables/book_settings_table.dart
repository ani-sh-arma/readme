import 'package:drift/drift.dart';

import 'books_table.dart';

class BookSettings extends Table {
  IntColumn get bookId =>
      integer().references(Books, #id, onDelete: KeyAction.cascade)();
  RealColumn get fontSize => real().withDefault(const Constant(16.0))();
  TextColumn get fontFamily =>
      text().withDefault(const Constant('Default'))();
  RealColumn get lineHeight => real().withDefault(const Constant(1.5))();
  TextColumn get theme =>
      text().withDefault(const Constant('Light'))(); // Light/Dark/Sepia/Amoled/Solarized/Custom
  RealColumn get brightness => real().withDefault(const Constant(1.0))();
  TextColumn get scrollMode =>
      text().withDefault(const Constant('paged'))(); // paged / continuous
  TextColumn get customBg => text().nullable()(); // hex color
  TextColumn get customFg => text().nullable()(); // hex color
  TextColumn get customAccent => text().nullable()(); // hex color

  @override
  Set<Column> get primaryKey => {bookId};
}
