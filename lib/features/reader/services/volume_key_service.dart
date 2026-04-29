import 'dart:io';

import 'package:flutter/services.dart';

/// Listens to hardware volume button presses on Android and translates them
/// into page-turn events. On iOS this is not supported.
class VolumeKeyService {
  static const _channel = EventChannel('com.example.readme/volume_keys');

  static Stream<String>? _stream;

  /// Returns a broadcast stream of 'up' or 'down' events on Android,
  /// or an empty stream on other platforms.
  static Stream<String> get events {
    if (!Platform.isAndroid) return const Stream.empty();
    _stream ??= _channel
        .receiveBroadcastStream()
        .cast<String>();
    return _stream!;
  }
}
