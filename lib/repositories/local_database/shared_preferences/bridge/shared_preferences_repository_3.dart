import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/utils.dart';

class SharedPreferencesRepository implements LocalDatabaseRepository {
  SharedPreferencesRepository(this._ref);

  final Ref _ref;

  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = _ref.read(sharedPreferencesProvider);
    await db.setInt(key.name, value);
  }

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    final db = _ref.read(sharedPreferencesProvider);
    return db.getInt(key.name);
  }
}
