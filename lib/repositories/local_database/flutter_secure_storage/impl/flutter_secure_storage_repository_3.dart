import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/utils.dart';

final class FlutterSecureStorageRepository extends LocalDatabaseRepository {
  FlutterSecureStorageRepository(this._ref);

  final Ref _ref;

  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = _ref.read(flutterSecureStorageProvider);
    await db.write(key: key.name, value: value.toString());
  }

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    final db = _ref.read(flutterSecureStorageProvider);
    final value = await db.read(key: key.name);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}
