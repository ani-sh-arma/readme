import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/theme/reader_style.dart';
import '../../../data/database/app_database.dart';
import '../bloc/reader_cubit.dart';

class HtmlReader extends StatefulWidget {
  const HtmlReader({super.key, required this.book});

  final Book book;

  @override
  State<HtmlReader> createState() => _HtmlReaderState();
}

class _HtmlReaderState extends State<HtmlReader> {
  late final WebViewController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            if (mounted) {
              setState(() => _error = error.description);
            }
          },
        ),
      );
    _load();
  }

  Future<void> _load() async {
    try {
      final file = File(widget.book.filePath);
      final style = resolveReaderStyle(context.read<ReaderCubit>().state.settings);
      final rawHtml = await file.readAsString();
      final html = _wrapHtml(rawHtml, style);
      await _controller.loadHtmlString(html, baseUrl: file.parent.uri.toString());
    } catch (error) {
      if (mounted) {
        setState(() => _error = error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = resolveReaderStyle(context.watch<ReaderCubit>().state.settings);
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(_error!, style: TextStyle(color: style.foreground)),
        ),
      );
    }

    return Container(
      color: style.background,
      child: WebViewWidget(controller: _controller),
    );
  }

  String _wrapHtml(String body, ReaderStyle style) {
    final background = '#${style.background.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
    final foreground = '#${style.foreground.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
    final accent = '#${style.accent.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
    final fontFamily = style.fontFamily ?? 'sans-serif';

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      margin: 0;
      padding: 24px;
      background: $background;
      color: $foreground;
      font-family: $fontFamily;
      font-size: ${style.fontSize}px;
      line-height: ${style.lineHeight};
    }
    img {
      max-width: 100%;
      height: auto;
    }
    a {
      color: $accent;
    }
  </style>
</head>
<body>
$body
</body>
</html>
''';
  }
}
