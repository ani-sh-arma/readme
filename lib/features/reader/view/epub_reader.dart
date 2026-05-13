import 'dart:io';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/database/app_database.dart';
import '../bloc/reader_cubit.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({super.key, required this.book});

  final Book book;

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  EpubController? _controller;
  String? _initError;
  bool _restoreSavedPositionOnLoad = true;
  bool _didAttemptInitialRestore = false;

  @override
  void initState() {
    super.initState();
    _initController(useSavedCfi: true);
  }

  void _initController({required bool useSavedCfi}) {
    _restoreSavedPositionOnLoad = useSavedCfi;
    _didAttemptInitialRestore = false;
    final file = File(widget.book.filePath);
    if (!file.existsSync()) {
      _initError = 'File not found:\n${widget.book.filePath}';
      return;
    }
    try {
      _controller = EpubController(document: EpubDocument.openFile(file));
    } catch (e) {
      _initError = e.toString();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _retryFromStart() {
    _controller?.dispose();
    setState(() {
      _initError = null;
      _controller = null;
      _initController(useSavedCfi: false);
    });
  }

  void _restoreSavedPositionIfNeeded() {
    if (!_restoreSavedPositionOnLoad || _didAttemptInitialRestore) {
      return;
    }

    final savedCfi = widget.book.currentPosition;
    if (savedCfi.isEmpty) {
      _didAttemptInitialRestore = true;
      return;
    }

    _didAttemptInitialRestore = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      try {
        _controller?.gotoEpubCfi(savedCfi, duration: Duration.zero);
      } catch (e) {
        debugPrint('Failed to restore EPUB position: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReaderCubit>().state;
    final settings = state.settings;

    final preset = ReaderThemePreset.values.firstWhere(
      (p) => p.label == (settings?.theme ?? 'Light'),
      orElse: () => ReaderThemePreset.light,
    );
    Color bg = preset.background;
    Color fg = preset.foreground;
    if (preset == ReaderThemePreset.custom &&
        settings?.customBg != null &&
        settings?.customFg != null) {
      bg = Color(int.parse(settings!.customBg!.replaceFirst('#', '0xFF')));
      fg = Color(int.parse(settings.customFg!.replaceFirst('#', '0xFF')));
    }

    if (_initError != null || _controller == null) {
      return _ErrorView(
        message: _initError ?? 'Failed to load EPUB',
        onRetry: _retryFromStart,
        bg: bg,
        fg: fg,
      );
    }

    return Container(
      color: bg,
      child: EpubView(
        controller: _controller!,
        onDocumentLoaded: (_) => _restoreSavedPositionIfNeeded(),
        onDocumentError: (e) {
          debugPrint('EPUB error: $e');
          if (mounted) {
            setState(() => _initError = e.toString());
          }
        },
        onChapterChanged: (_) {
          final cfi = _controller?.generateEpubCfi();
          if (cfi != null && cfi.isNotEmpty) {
            context.read<ReaderCubit>().updatePosition(cfi);
          }
        },
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: DefaultBuilderOptions(
            textStyle: TextStyle(
              fontSize: settings?.fontSize ?? 16.0,
              height: settings?.lineHeight ?? 1.5,
              fontFamily: _fontFamily(settings?.fontFamily),
              color: fg,
            ),
          ),
        ),
      ),
    );
  }

  String? _fontFamily(String? family) {
    if (family == null || family == 'Default') return null;
    return family;
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
    required this.bg,
    required this.fg,
  });

  final String message;
  final VoidCallback onRetry;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 56, color: fg),
          const SizedBox(height: 12),
          Text(
            'Could not open this EPUB',
            style: TextStyle(color: fg, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: fg.withValues(alpha: 0.8), fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry from start'),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
