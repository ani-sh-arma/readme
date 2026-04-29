import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../library/widgets/book_items.dart';
import '../../reader/view/reader_screen.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Collections'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Reading'),
              Tab(text: 'Read'),
              Tab(text: 'Favourites'),
              Tab(text: 'Bookmarked'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BookStreamList(
              stream: context.read<BookRepository>().watchCurrentlyReading(),
              emptyMessage: 'No books in progress.',
            ),
            _BookStreamList(
              stream: context.read<BookRepository>().watchReadList(),
              emptyMessage: 'No books marked as read.',
            ),
            _BookStreamList(
              stream: context.read<BookRepository>().watchFavorites(),
              emptyMessage: 'No favourites yet.',
            ),
            _BookmarkedList(),
            _BookStreamList(
              stream: context.read<BookRepository>().watchHistory(),
              emptyMessage: 'No reading history yet.',
            ),
          ],
        ),
      ),
    );
  }
}

class _BookStreamList extends StatelessWidget {
  const _BookStreamList({required this.stream, required this.emptyMessage});

  final Stream<List<Book>> stream;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final books = snapshot.data ?? [];
        if (books.isEmpty) {
          return Center(child: Text(emptyMessage));
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: books.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) => BookListItem(
            book: books[i],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ReaderScreen(book: books[i]),
                fullscreenDialog: true,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BookmarkedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We show all books that have at least one bookmark
    // by streaming all books then filtering async.
    return StreamBuilder<List<Book>>(
      stream: context.read<BookRepository>().watchAllBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final all = snapshot.data ?? [];
        return FutureBuilder<List<Book>>(
          future: _filterBookmarked(context, all),
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final books = snap.data!;
            if (books.isEmpty) {
              return const Center(child: Text('No bookmarked books.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: books.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (ctx2, i) => BookListItem(
                book: books[i],
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReaderScreen(book: books[i]),
                    fullscreenDialog: true,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Book>> _filterBookmarked(
    BuildContext context,
    List<Book> all,
  ) async {
    final bmRepo = context.read<BookmarkRepository>();
    final result = <Book>[];
    for (final b in all) {
      if (await bmRepo.hasBookmarks(b.id)) result.add(b);
    }
    return result;
  }
}
