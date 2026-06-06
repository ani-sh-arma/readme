import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/theme/reader_style.dart';
import '../../../data/database/app_database.dart';
import '../bloc/reader_bloc.dart';
import '../bloc/reader_cubit.dart';
import '../services/epub_document_service.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({super.key, required this.book});

  final Book book;

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  final _documentService = EpubDocumentService();
  late final WebViewController _controller;
  EpubWebDocument? _document;
  String? _error;
  int _pageIndex = 0;
  double _pageOffset = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'ReadMeEpub',
        onMessageReceived: (message) => _onJavaScriptMessage(message.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _onNavigationRequest,
          onPageFinished: (_) => _restoreScrollOffset(),
          onWebResourceError: (error) {
            if (error.isForMainFrame == true && mounted) {
              setState(() => _error = error.description);
            }
          },
        ),
      );
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    if (mounted) {
      setState(() {
        _error = null;
        _isLoading = true;
      });
    }

    try {
      final file = File(widget.book.filePath);
      if (!file.existsSync()) {
        throw FileSystemException('EPUB file not found', file.path);
      }

      final document = await _documentService.load(file);
      if (!mounted) return;
      final position = _EpubPosition.tryParse(widget.book.currentPosition);
      _document = document;
      _pageIndex = (position?.chapter ?? 0).clamp(0, document.pages.length - 1);
      _pageOffset = position?.offset ?? 0;
      await _loadPage(_pageIndex, offset: _pageOffset);
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadPage(int pageIndex, {double offset = 0}) async {
    final document = _document;
    if (document == null ||
        pageIndex < 0 ||
        pageIndex >= document.pages.length) {
      return;
    }

    final style = resolveReaderStyle(
      context.read<ReaderCubit>().state.settings,
    );
    final page = document.pages[pageIndex];
    if (mounted) {
      setState(() {
        _pageIndex = pageIndex;
        _pageOffset = offset.clamp(0, 1);
        _isLoading = true;
        _error = null;
      });
    }

    final html = _injectReaderShell(page.html, style);
    await _controller.loadHtmlString(html, baseUrl: page.baseUrl);
    if (!mounted) return;
    setState(() => _isLoading = false);
    _savePosition();
  }

  NavigationDecision _onNavigationRequest(NavigationRequest request) {
    final document = _document;
    if (!request.isMainFrame || document == null) {
      return NavigationDecision.navigate;
    }

    final uri = Uri.tryParse(request.url);
    if (uri == null || uri.scheme == 'data' || uri.scheme == 'about') {
      return NavigationDecision.navigate;
    }
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return NavigationDecision.prevent;
    }

    final decodedPath = Uri.decodeFull(uri.path).replaceAll('\\', '/');
    final targetIndex = document.pages.indexWhere(
      (page) => decodedPath.endsWith('/${page.path}'),
    );
    if (targetIndex >= 0 && targetIndex != _pageIndex) {
      _loadPage(targetIndex);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _onJavaScriptMessage(String rawMessage) {
    try {
      final message = jsonDecode(rawMessage) as Map<String, dynamic>;
      switch (message['type']) {
        case 'progress':
          _pageOffset = ((message['offset'] as num?)?.toDouble() ?? 0).clamp(
            0,
            1,
          );
          _savePosition();
          return;
        case 'tap':
          context.read<ReaderCubit>().toggleUi();
          return;
      }
    } catch (error) {
      debugPrint('Ignoring invalid EPUB WebView message: $error');
    }
  }

  void _savePosition() {
    final document = _document;
    if (!mounted || document == null || document.pages.isEmpty) return;

    final position = _EpubPosition(chapter: _pageIndex, offset: _pageOffset);
    final progress = ((_pageIndex + _pageOffset) / document.pages.length).clamp(
      0.0,
      1.0,
    );
    context.read<ReaderCubit>().updatePosition(
      position.encode(),
      progress: progress,
    );
  }

  Future<void> _restoreScrollOffset() async {
    final offset = _pageOffset.clamp(0, 1);
    await _controller.runJavaScript(
      'window.readMeRestoreOffset && window.readMeRestoreOffset($offset);',
    );
  }

  Future<void> _applyTheme(ReaderStyle style) async {
    final css = jsonEncode(_styleCss(style));
    await _controller.runJavaScript(
      'window.readMeApplyTheme && window.readMeApplyTheme($css);',
    );
  }

  @override
  Widget build(BuildContext context) {
    final readerState = context.watch<ReaderCubit>().state;
    final style = resolveReaderStyle(readerState.settings);
    final document = _document;

    return BlocListener<ReaderCubit, ReaderState>(
      listenWhen: (previous, current) => previous.settings != current.settings,
      listener: (context, state) =>
          _applyTheme(resolveReaderStyle(state.settings)),
      child: Container(
        color: style.background,
        child: _error != null
            ? _ErrorView(message: _error!, onRetry: _loadDocument, style: style)
            : Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (document != null)
                    _PageControls(
                      currentPage: _pageIndex + 1,
                      totalPages: document.pages.length,
                      onPrevious: _pageIndex > 0
                          ? () => _loadPage(_pageIndex - 1)
                          : null,
                      onNext: _pageIndex < document.pages.length - 1
                          ? () => _loadPage(_pageIndex + 1)
                          : null,
                    ),
                ],
              ),
      ),
    );
  }

  String _injectReaderShell(String html, ReaderStyle style) {
    final shell =
        '''
<style id="readme-theme">${_styleCss(style)}</style>
<script>
  window.readMeApplyTheme = function(css) {
    document.getElementById('readme-theme').textContent = css;
  };
  window.readMeRestoreOffset = function(offset) {
    requestAnimationFrame(function() {
      var root = document.documentElement;
      var maxScroll = Math.max(0, root.scrollHeight - window.innerHeight);
      window.scrollTo(0, maxScroll * offset);
    });
  };
  (function() {
    var timer;
    function reportProgress() {
      clearTimeout(timer);
      timer = setTimeout(function() {
        var root = document.documentElement;
        var maxScroll = Math.max(0, root.scrollHeight - window.innerHeight);
        var offset = maxScroll === 0 ? 0 : window.scrollY / maxScroll;
        ReadMeEpub.postMessage(JSON.stringify({type: 'progress', offset: offset}));
      }, 120);
    }
    window.addEventListener('scroll', reportProgress, {passive: true});
    document.addEventListener('click', function(event) {
      if (!event.target.closest || !event.target.closest('a')) {
        ReadMeEpub.postMessage(JSON.stringify({type: 'tap'}));
      }
    });
  })();
</script>
''';

    final headEnd = html.toLowerCase().indexOf('</head>');
    if (headEnd >= 0) {
      return '${html.substring(0, headEnd)}$shell${html.substring(headEnd)}';
    }
    return '<!DOCTYPE html><html><head>$shell</head><body>$html</body></html>';
  }

  String _styleCss(ReaderStyle style) {
    final background = _hex(style.background);
    final foreground = _hex(style.foreground);
    final accent = _hex(style.accent);
    final fontFamily = style.fontFamily ?? 'serif';

    return '''
:root { color-scheme: light dark; }
html, body {
  background: $background !important;
  color: $foreground !important;
}
body {
  margin: 0 !important;
  padding: 24px 20px 88px !important;
  font-family: "$fontFamily", serif !important;
  font-size: ${style.fontSize}px !important;
  line-height: ${style.lineHeight} !important;
  overflow-wrap: break-word;
}
p, div, span, li, blockquote, h1, h2, h3, h4, h5, h6 {
  color: inherit !important;
  line-height: inherit !important;
}
img, svg, video {
  max-width: 100% !important;
  height: auto !important;
}
a { color: $accent !important; }
''';
  }

  String _hex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}

class _PageControls extends StatelessWidget {
  const _PageControls({
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      right: 12,
      bottom: 16,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavigationButton(
              icon: Icons.chevron_left,
              tooltip: 'Previous chapter',
              onPressed: onPrevious,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  '$currentPage / $totalPages',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            _NavigationButton(
              icon: Icons.chevron_right,
              tooltip: 'Next chapter',
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
    required this.style,
  });

  final String message;
  final VoidCallback onRetry;
  final ReaderStyle style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 56, color: style.foreground),
            const SizedBox(height: 12),
            Text(
              'Could not open this EPUB',
              style: TextStyle(color: style.foreground, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: style.foreground.withValues(alpha: 0.8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

class _EpubPosition {
  const _EpubPosition({required this.chapter, required this.offset});

  final int chapter;
  final double offset;

  String encode() => jsonEncode({'chapter': chapter, 'offset': offset});

  static _EpubPosition? tryParse(String rawPosition) {
    if (rawPosition.isEmpty) return null;
    try {
      final json = jsonDecode(rawPosition) as Map<String, dynamic>;
      return _EpubPosition(
        chapter: (json['chapter'] as num?)?.toInt() ?? 0,
        offset: ((json['offset'] as num?)?.toDouble() ?? 0).clamp(0, 1),
      );
    } catch (_) {
      return null;
    }
  }
}
