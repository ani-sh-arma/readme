import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Platform channel wrapper for CBR (RAR) extraction on Android.
/// On iOS and other platforms this is not supported.
class CbrExtractorService {
  static const _channel = MethodChannel('com.example.readme/cbr');

  /// Extracts a CBR file at [cbrPath] to a temporary directory and returns
  /// sorted image file paths. Returns null on non-Android platforms.
  static Future<List<String>?> extract(String cbrPath) async {
    if (!Platform.isAndroid) return null;

    final tmp = await getTemporaryDirectory();
    final fileName = p.basenameWithoutExtension(cbrPath);
    final destDir = p.join(tmp.path, 'cbr_$fileName');

    try {
      final result = await _channel.invokeListMethod<String>('extractCbr', {
        'path': cbrPath,
        'destDir': destDir,
      });
      return result;
    } on PlatformException catch (e) {
      throw Exception('CBR extraction failed: ${e.message}');
    }
  }
}
