import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/bookmark_repository.dart';

class BookGridItem extends StatelessWidget {
  const BookGridItem({
    super.key,
    required this.book,
    required this.onTap,
    this.onLongPress,
  });

  final Book book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _CoverImage(book: book)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _BookMeta(book: book),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  const BookListItem({
    super.key,
    required this.book,
    required this.onTap,
    this.onLongPress,
    this.trailing,
  });

  final Book book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: SizedBox(
        width: 48,
        height: 64,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: _CoverImage(book: book),
        ),
      ),
      title: Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${book.author}${book.lastReadProgress > 0 ? ' • ${_progressLabel(book.lastReadProgress)}' : ''}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing:
          trailing ??
          Text(
            book.format.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
    );
  }

  String _progressLabel(double progress) =>
      '${(progress * 100).round().clamp(0, 100)}%';
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final coverPath = book.coverPath;
    if (coverPath != null && File(coverPath).existsSync()) {
      return Image.file(
        File(coverPath),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _Placeholder(book: book),
      );
    }
    return _Placeholder(book: book);
  }
}

class _BookMeta extends StatelessWidget {
  const _BookMeta({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final progress = book.lastReadProgress.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (progress > 0)
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(value: progress, minHeight: 4),
          ),
        const SizedBox(height: 4),
        FutureBuilder<Duration>(
          future: context.read<ReadingSessionRepository>().totalReadingTime(
            book.id,
          ),
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            final minutes = duration.inMinutes;
            final label = minutes <= 0 ? 'Not started' : '$minutes min read';
            final suffix = progress > 0
                ? ' • ${(progress * 100).round().clamp(0, 100)}%'
                : '';
            return Text(
              '$label$suffix',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall,
            );
          },
        ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _iconForFormat(book.format),
              size: 36,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                book.format.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForFormat(String format) {
    switch (format) {
      case 'epub':
        return Icons.menu_book_outlined;
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'cbz':
      case 'cbr':
        return Icons.collections_outlined;
      case 'txt':
        return Icons.article_outlined;
      case 'html':
      case 'htm':
        return Icons.html_outlined;
      default:
        return Icons.description_outlined;
    }
  }
}
