import 'package:equatable/equatable.dart';

import '../../../data/database/tables/books_table.dart';

enum LibrarySortField { title, author, dateAdded, lastRead, fileSize, format }

enum LibraryViewMode { grid, list }

class LibraryState extends Equatable {
  const LibraryState({
    this.books = const [],
    this.isLoading = false,
    this.error,
    this.sortField = LibrarySortField.dateAdded,
    this.ascending = false,
    this.viewMode = LibraryViewMode.grid,
    this.formatFilter,
    this.statusFilter,
    this.favoritesOnly = false,
    this.searchQuery = '',
    this.scanProgress,
  });

  final List<Book> books;
  final bool isLoading;
  final String? error;
  final LibrarySortField sortField;
  final bool ascending;
  final LibraryViewMode viewMode;
  final String? formatFilter; // BookFormat.name or null
  final String? statusFilter; // 'unread' | 'reading' | 'read' | null
  final bool favoritesOnly;
  final String searchQuery;
  final String? scanProgress; // path being scanned

  List<Book> get filteredBooks {
    var list = List<Book>.from(books);

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list
          .where(
            (b) =>
                b.title.toLowerCase().contains(q) ||
                b.author.toLowerCase().contains(q),
          )
          .toList();
    }

    if (formatFilter != null) {
      list = list.where((b) => b.format == formatFilter).toList();
    }

    if (statusFilter != null) {
      list = list.where((b) {
        switch (statusFilter) {
          case 'read':
            return b.isRead;
          case 'reading':
            return !b.isRead && b.currentPosition.isNotEmpty;
          case 'unread':
            return !b.isRead && b.currentPosition.isEmpty;
          default:
            return true;
        }
      }).toList();
    }

    if (favoritesOnly) {
      list = list.where((b) => b.isFavorite).toList();
    }

    list.sort((a, b) {
      int cmp;
      switch (sortField) {
        case LibrarySortField.title:
          cmp = a.title.compareTo(b.title);
        case LibrarySortField.author:
          cmp = a.author.compareTo(b.author);
        case LibrarySortField.dateAdded:
          cmp = a.dateAdded.compareTo(b.dateAdded);
        case LibrarySortField.lastRead:
          final aLast = a.lastOpenedAt ?? DateTime(0);
          final bLast = b.lastOpenedAt ?? DateTime(0);
          cmp = aLast.compareTo(bLast);
        case LibrarySortField.fileSize:
          cmp = a.fileSize.compareTo(b.fileSize);
        case LibrarySortField.format:
          cmp = a.format.compareTo(b.format);
      }
      return ascending ? cmp : -cmp;
    });

    return list;
  }

  LibraryState copyWith({
    List<Book>? books,
    bool? isLoading,
    String? error,
    LibrarySortField? sortField,
    bool? ascending,
    LibraryViewMode? viewMode,
    String? formatFilter,
    String? statusFilter,
    bool? favoritesOnly,
    String? searchQuery,
    String? scanProgress,
    bool clearError = false,
    bool clearScanProgress = false,
    bool clearFormatFilter = false,
    bool clearStatusFilter = false,
  }) {
    return LibraryState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      sortField: sortField ?? this.sortField,
      ascending: ascending ?? this.ascending,
      viewMode: viewMode ?? this.viewMode,
      formatFilter:
          clearFormatFilter ? null : (formatFilter ?? this.formatFilter),
      statusFilter:
          clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
      searchQuery: searchQuery ?? this.searchQuery,
      scanProgress:
          clearScanProgress ? null : (scanProgress ?? this.scanProgress),
    );
  }

  @override
  List<Object?> get props => [
    books,
    isLoading,
    error,
    sortField,
    ascending,
    viewMode,
    formatFilter,
    statusFilter,
    favoritesOnly,
    searchQuery,
    scanProgress,
  ];
}
