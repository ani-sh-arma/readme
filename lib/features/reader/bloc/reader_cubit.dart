import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/tables/book_settings_table.dart';
import '../../../data/database/tables/books_table.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/bookmark_repository.dart';
import 'reader_bloc.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit(
    this._bookRepo,
    this._bookmarkRepo,
    this._bookSettingsRepo,
    this._readingSessionRepo,
  ) : super(const ReaderState());

  final BookRepository _bookRepo;
  final BookmarkRepository _bookmarkRepo;
  final BookSettingsRepository _bookSettingsRepo;
  final ReadingSessionRepository _readingSessionRepo;

  StreamSubscription<dynamic>? _bookmarksSub;
  StreamSubscription<dynamic>? _settingsSub;
  Timer? _positionDebounce;
  String _pendingPosition = '';

  Future<void> open(Book book) async {
    emit(state.copyWith(book: book, isLoading: true));

    // Load or create default settings
    var settings = await _bookSettingsRepo.getSettings(book.id);
    if (settings == null) {
      await _bookSettingsRepo.upsertSettings(
        BookSettingsCompanion(bookId: Value(book.id)),
      );
      settings = await _bookSettingsRepo.getSettings(book.id);
    }

    // Start reading session
    final sessionId = await _readingSessionRepo.startSession(book.id);

    emit(
      state.copyWith(
        book: book,
        settings: settings,
        isLoading: false,
        sessionId: sessionId,
      ),
    );

    // Subscribe to bookmarks and settings changes
    await _bookmarksSub?.cancel();
    _bookmarksSub = _bookmarkRepo.watchBookmarksForBook(book.id).listen(
      (bms) => emit(state.copyWith(bookmarks: bms)),
    );

    await _settingsSub?.cancel();
    _settingsSub = _bookSettingsRepo.watchSettings(book.id).listen(
      (s) {
        if (s != null) emit(state.copyWith(settings: s));
      },
    );
  }

  void updatePosition(String position) {
    _pendingPosition = position;
    final book = state.book;
    if (book != null && book.currentPosition != position) {
      emit(
        state.copyWith(
          book: book.copyWith(
            currentPosition: position,
            lastOpenedAt: Value(DateTime.now()),
          ),
        ),
      );
    }
    _positionDebounce?.cancel();
    _positionDebounce = Timer(const Duration(seconds: 2), () {
      final activeBook = state.book;
      if (activeBook != null) {
        _bookRepo.updatePosition(activeBook.id, _pendingPosition);
      }
    });
  }

  Future<void> addBookmark({String label = ''}) async {
    final book = state.book;
    if (book == null) return;
    var pos = _pendingPosition;
    if (pos.isEmpty) {
      pos = book.currentPosition;
    }
    if (pos.isEmpty) return;
    await _bookmarkRepo.addBookmark(book.id, pos, label: label);
  }

  Future<void> deleteBookmark(int id) async {
    await _bookmarkRepo.deleteBookmark(id);
  }

  Future<void> updateSettings(BookSettingsCompanion settings) async {
    await _bookSettingsRepo.upsertSettings(settings);
  }

  void toggleUi() {
    emit(state.copyWith(showUi: !state.showUi));
  }

  Future<void> close() async {
    _positionDebounce?.cancel();

    // Flush pending position
    final book = state.book;
    if (book != null && _pendingPosition.isNotEmpty) {
      await _bookRepo.updatePosition(book.id, _pendingPosition);
    }

    // End reading session
    if (state.sessionId != null) {
      await _readingSessionRepo.endSession(state.sessionId!, 0);
    }

    await _bookmarksSub?.cancel();
    await _settingsSub?.cancel();

    emit(const ReaderState());
  }
}
