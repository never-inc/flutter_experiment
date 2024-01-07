import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class TmpCacheDirectory {
  TmpCacheDirectory._();

  static late final Directory _dir;

  static Future<void> configure() async {
    if (Platform.isIOS) {
      _dir = Directory.systemTemp;
    } else {
      _dir = await getTemporaryDirectory();
    }
  }

  static Future<List<File>> fetchFiles() async {
    final list = await compute<Directory, List<File>>(
      (dir) {
        return dir
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList();
      },
      _dir,
    );
    return list;
  }

  static Future<void> deleteFiles() async {
    await compute<Directory, void>(
      (dir) {
        final list = dir
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList();
        for (final file in list) {
          file.deleteSync();
          debugPrint('delete: ${file.path}');
        }
      },
      _dir,
    );
  }
}
