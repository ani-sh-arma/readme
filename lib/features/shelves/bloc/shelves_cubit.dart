import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/shelf_repository.dart';
import 'shelves_bloc.dart';

class ShelvesCubit extends Cubit<ShelvesState> {
  ShelvesCubit(this._shelfRepo, this._bookRepo) : super(const ShelvesState());

  final ShelfRepository _shelfRepo;
  final BookRepository _bookRepo;
  StreamSubscription<dynamic>? _sub;

  Future<void> start() async {
    emit(state.copyWith(isLoading: true));
    await _sub?.cancel();
    _sub = _shelfRepo.watchAllShelves().listen(
      (shelves) => emit(state.copyWith(shelves: shelves, isLoading: false)),
    );
  }

  Future<void> addDirectory(Directory dir) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _shelfRepo.registerDirectoryTree(dir);
      await _bookRepo.scanDirectory(dir);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> removeShelf(int id) async {
    await _shelfRepo.removeShelf(id);
  }

  Future<void> createSubDirectory(String parentPath, String name) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _shelfRepo.createDirectory(parentPath, name);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
