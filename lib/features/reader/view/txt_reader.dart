import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/reader_cubit.dart';

class TxtReader extends StatefulWidget {
  const TxtReader({super.key, required this.book});

  final Book book;

  @override
  State<TxtReader> createState() => _TxtReaderState();
}

class _TxtReaderState extends State<TxtReader> {
  String? _content;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  Future<void> _loadFile() async {
    try {
      final content = await File(widget.book.filePath).readAsString();
      if (mounted) setState(() => _content = content);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }
    if (_content == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final state = context.watch<ReaderCubit>().state;
    final settings = state.settings;

    // Resolve colors from theme preset
    final preset = ReaderThemePreset.values.firstWhere(
      (p) => p.label == (settings?.theme ?? 'Light'),
      orElse: () => ReaderThemePreset.light,
    );

    Color bg = preset.background;
    Color fg = preset.foreground;

    if (preset == ReaderThemePreset.custom && settings?.customBg != null) {
      bg = Color(int.parse(settings!.customBg!.replaceFirst('#', '0xFF')));
      fg = Color(int.parse(settings.customFg!.replaceFirst('#', '0xFF')));
    }

    return Container(
      color: bg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: SelectableText(
          _content!,
          style: TextStyle(
            fontSize: settings?.fontSize ?? 16.0,
            height: settings?.lineHeight ?? 1.5,
            fontFamily: _fontFamily(settings?.fontFamily),
            color: fg,
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
