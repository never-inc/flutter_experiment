import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements LocalDatabaseRepository {
  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = getIt<SharedPreferences>();
    await db.setInt(key.name, value);
  }

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    final db = getIt<SharedPreferences>();
    return db.getInt(key.name);
  }
}
