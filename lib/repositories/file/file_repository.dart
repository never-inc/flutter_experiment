import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileRepository {
  FileRepository(this._temporaryDirectory);

  static late final FileRepository getInstance;

  static Future<void> setup() async {
    final Directory dir;
    if (Platform.isIOS) {
      // /Users/xxx/Library/Developer/CoreSimulator/Devices/8453C0AB-E640-4044-87E3-7A891199062E/data/Containers/Data/Application/1B2DA1B2-CFEA-4070-8F23-F83A7B8DF6CE/tmp/
      dir = Directory.systemTemp;
    } else {
      // /data/user/0/com.example.flutter_sample/cache/
      dir = await getTemporaryDirectory();
    }
    getInstance = FileRepository(dir);
  }

  final Directory _temporaryDirectory;

  List<File> fetchTempFiles() {
    return _temporaryDirectory
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();
  }

  void clearTempFiles() {
    final list = _temporaryDirectory
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();
    for (final file in list) {
      file.deleteSync();
    }
  }
}
