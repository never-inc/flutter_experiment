import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/utils.dart';

class FlutterSecureStorageRepository {
  FlutterSecureStorageRepository(this._ref);

  final Ref _ref;

  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = _ref.read(flutterSecureStorageProvider);
    await db.write(key: key.name, value: value.toString());
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    final db = _ref.read(flutterSecureStorageProvider);
    final value = await db.read(key: key.name);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}
