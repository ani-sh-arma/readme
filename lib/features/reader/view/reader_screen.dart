import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../settings/bloc/settings_cubit.dart';
import '../bloc/reader_bloc.dart';
import '../bloc/reader_cubit.dart';
import '../widgets/book_settings_panel.dart';
import 'cbr_reader.dart';
import 'cbz_reader.dart';
import 'epub_reader.dart';
import 'html_reader.dart';
import 'mobi_reader.dart';
import 'pdf_reader.dart';
import 'txt_reader.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().state;
    final defaults = ReaderDefaults(
      fontSize: settings.defaultFontSize,
      fontFamily: settings.defaultFontFamily,
      lineHeight: settings.defaultLineHeight,
      scrollMode: settings.defaultScrollMode,
      theme: settings.defaultReaderTheme,
    );
    return BlocProvider(
      create: (ctx) => ReaderCubit(
        ctx.read<BookRepository>(),
        ctx.read<BookmarkRepository>(),
        ctx.read<BookSettingsRepository>(),
        ctx.read<ReadingSessionRepository>(),
        ctx.read<HighlightRepository>(),
      )..open(book, defaults: defaults),
      child: _ReaderView(book: book),
    );
  }
}

class _ReaderView extends StatefulWidget {
  const _ReaderView({required this.book});

  final Book book;

  @override
  State<_ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<_ReaderView> {
  @override
  void dispose() {
    context.read<ReaderCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReaderCubit, ReaderState>(
      listenWhen: (previous, current) =>
          previous.closeRequested != current.closeRequested,
      listener: (context, state) {
        if (state.closeRequested && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: GestureDetector(
                onTap: () => context.read<ReaderCubit>().toggleUi(),
                child: Stack(
                  children: [
                    // Reader content
                    _buildReader(state),
                    // Top chrome
                    if (state.showUi && state.book != null)
                      _TopBar(book: state.book!),
                    // Bottom chrome
                    if (state.showUi) const _BottomBar(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReader(ReaderState state) {
    final format = widget.book.format;
    switch (format) {
      case 'epub':
        return EpubReader(book: widget.book);
      case 'pdf':
        return PdfReader(book: widget.book);
      case 'txt':
        return TxtReader(book: widget.book);
      case 'html':
      case 'htm':
        return HtmlReader(book: widget.book);
      case 'cbz':
        return CbzReader(book: widget.book);
      case 'cbr':
        return CbrReader(book: widget.book);
      case 'mobi':
      case 'azw':
      case 'azw3':
        return MobiReader(book: widget.book);
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_outlined, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Format "${widget.book.format.toUpperCase()}" is not yet supported.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
    }
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  book.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.white,
                ),
                tooltip: 'Add bookmark',
                onPressed: () => _showAddBookmark(context),
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                tooltip: 'Reader settings',
                onPressed: () => _showSettings(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddBookmark(BuildContext context) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add bookmark'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Optional label'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ReaderCubit>().addBookmark(
                label: controller.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Bookmark added')));
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<ReaderCubit>(),
        child: const BookSettingsPanel(),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (context, state) {
        final bookmarks = state.bookmarks;
        final book = state.book;
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (book?.currentPosition.isNotEmpty ?? false)
                          ? 'Position: ${book!.currentPosition}'
                          : '',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    if (bookmarks.isNotEmpty)
                      GestureDetector(
                        onTap: () => _showBookmarks(context, state),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bookmarks_outlined,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${bookmarks.length}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBookmarks(BuildContext context, ReaderState state) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bookmarks',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ...state.bookmarks.map((bm) {
              final bookmark = bm;
              return ListTile(
                leading: const Icon(Icons.bookmark_outlined),
                title: Text(
                  bookmark.label.isNotEmpty
                      ? bookmark.label
                      : bookmark.position,
                ),
                subtitle: Text(bookmark.createdAt.toLocal().toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    context.read<ReaderCubit>().deleteBookmark(bookmark.id);
                    Navigator.pop(ctx);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
