import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../core/theme/reader_style.dart';
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
  late final ScrollController _scrollController;
  bool _autoScrollActive = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
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

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final progress = maxScroll <= 0
        ? 0.0
        : (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
    context.read<ReaderCubit>().updatePosition(
      _scrollController.offset.round().toString(),
      progress: progress,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
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
    final style = resolveReaderStyle(state.settings);
    _syncAutoScroll(state.settings?.autoScrollEnabled == true, state.settings?.autoScrollSpeed ?? 24);

    return Container(
      color: style.background,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(24),
        child: SelectableText(
          _content!,
          style: TextStyle(
            fontSize: style.fontSize,
            height: style.lineHeight,
            fontFamily: style.fontFamily,
            color: style.foreground,
          ),
        ),
      ),
    );
  }

  void _syncAutoScroll(bool enabled, double speed) {
    if (!enabled || !_scrollController.hasClients) {
      _autoScrollActive = false;
      return;
    }
    if (_autoScrollActive) return;
    _autoScrollActive = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (mounted &&
          _autoScrollActive &&
          _scrollController.hasClients &&
          _scrollController.offset < _scrollController.position.maxScrollExtent) {
        final next = (_scrollController.offset + speed).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );
        _scrollController.jumpTo(next);
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
      _autoScrollActive = false;
    });
  }
}
