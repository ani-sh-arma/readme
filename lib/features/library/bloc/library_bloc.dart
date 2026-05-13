import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(this._bookRepo) : super(const LibraryState()) {
    on<LibraryStarted>(_onStarted);
    on<LibraryBooksUpdated>(_onBooksUpdated);
    on<LibraryScanRequested>(_onScanRequested);
    on<LibraryScanProgressUpdated>(_onScanProgressUpdated);
    on<LibrarySortChanged>(_onSortChanged);
    on<LibraryViewModeToggled>(_onViewModeToggled);
    on<LibraryFormatFilterChanged>(_onFormatFilterChanged);
    on<LibraryStatusFilterChanged>(_onStatusFilterChanged);
    on<LibraryFavoritesFilterToggled>(_onFavoritesFilterToggled);
    on<LibrarySearchChanged>(_onSearchChanged);
    on<LibraryBookFavoriteToggled>(_onFavoriteToggled);
    on<LibraryBookReadToggled>(_onReadToggled);
    on<LibraryBookDeleted>(_onBookDeleted);
  }

  final BookRepository _bookRepo;

  Future<void> _onStarted(
    LibraryStarted event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await emit.forEach<List<Book>>(
      _bookRepo.watchAllBooks(),
      onData: (books) => state.copyWith(books: books, isLoading: false),
      onError: (e, _) => state.copyWith(error: e.toString(), isLoading: false),
    );
  }

  void _onBooksUpdated(LibraryBooksUpdated event, Emitter<LibraryState> emit) {
    emit(state.copyWith(books: event.books, isLoading: false));
  }

  Future<void> _onScanRequested(
    LibraryScanRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, scanProgress: event.directory.path));
    try {
      await _bookRepo.scanDirectory(
        event.directory,
        onProgress: (path) =>
            add(LibraryScanProgressUpdated(path)), // update UI progress
      );
      emit(state.copyWith(isLoading: false, clearScanProgress: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          clearScanProgress: true,
        ),
      );
    }
  }

  void _onScanProgressUpdated(
    LibraryScanProgressUpdated event,
    Emitter<LibraryState> emit,
  ) {
    emit(state.copyWith(scanProgress: event.path));
  }

  void _onSortChanged(LibrarySortChanged event, Emitter<LibraryState> emit) {
    emit(state.copyWith(sortField: event.field, ascending: event.ascending));
  }

  void _onViewModeToggled(
    LibraryViewModeToggled event,
    Emitter<LibraryState> emit,
  ) {
    emit(
      state.copyWith(
        viewMode: state.viewMode == LibraryViewMode.grid
            ? LibraryViewMode.list
            : LibraryViewMode.grid,
      ),
    );
  }

  void _onFormatFilterChanged(
    LibraryFormatFilterChanged event,
    Emitter<LibraryState> emit,
  ) {
    if (event.format == null) {
      emit(state.copyWith(clearFormatFilter: true));
    } else {
      emit(state.copyWith(formatFilter: event.format));
    }
  }

  void _onStatusFilterChanged(
    LibraryStatusFilterChanged event,
    Emitter<LibraryState> emit,
  ) {
    if (event.status == null) {
      emit(state.copyWith(clearStatusFilter: true));
    } else {
      emit(state.copyWith(statusFilter: event.status));
    }
  }

  void _onFavoritesFilterToggled(
    LibraryFavoritesFilterToggled event,
    Emitter<LibraryState> emit,
  ) {
    emit(state.copyWith(favoritesOnly: !state.favoritesOnly));
  }

  void _onSearchChanged(
    LibrarySearchChanged event,
    Emitter<LibraryState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _onFavoriteToggled(
    LibraryBookFavoriteToggled event,
    Emitter<LibraryState> emit,
  ) async {
    await _bookRepo.markFavorite(event.bookId, isFavorite: event.isFavorite);
  }

  Future<void> _onReadToggled(
    LibraryBookReadToggled event,
    Emitter<LibraryState> emit,
  ) async {
    await _bookRepo.markRead(event.bookId, isRead: event.isRead);
    await _bookRepo.markInReadList(event.bookId, inReadList: event.isRead);
  }

  Future<void> _onBookDeleted(
    LibraryBookDeleted event,
    Emitter<LibraryState> emit,
  ) async {
    await _bookRepo.deleteBook(event.bookId);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
