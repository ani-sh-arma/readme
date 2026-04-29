import 'dart:io';

import '../../../data/database/tables/books_table.dart';
import 'library_state.dart';

abstract class LibraryEvent {}

class LibraryStarted extends LibraryEvent {}

class LibraryBooksUpdated extends LibraryEvent {
  LibraryBooksUpdated(this.books);
  final List<Book> books;
}

class LibraryScanRequested extends LibraryEvent {
  LibraryScanRequested(this.directory);
  final Directory directory;
}

class LibrarySortChanged extends LibraryEvent {
  LibrarySortChanged(this.field, {this.ascending = true});
  final LibrarySortField field;
  final bool ascending;
}

class LibraryViewModeToggled extends LibraryEvent {}

class LibraryFormatFilterChanged extends LibraryEvent {
  LibraryFormatFilterChanged(this.format);
  final String? format;
}

class LibraryStatusFilterChanged extends LibraryEvent {
  LibraryStatusFilterChanged(this.status);
  final String? status;
}

class LibraryFavoritesFilterToggled extends LibraryEvent {}

class LibrarySearchChanged extends LibraryEvent {
  LibrarySearchChanged(this.query);
  final String query;
}

class LibraryBookFavoriteToggled extends LibraryEvent {
  LibraryBookFavoriteToggled(this.bookId, {required this.isFavorite});
  final int bookId;
  final bool isFavorite;
}

class LibraryBookDeleted extends LibraryEvent {
  LibraryBookDeleted(this.bookId);
  final int bookId;
}
