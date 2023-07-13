import 'package:flutter_sample/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = await SharedPreferences.getInstance();
    await db.setInt(key.name, value);
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    final db = await SharedPreferences.getInstance();
    return db.getInt(key.name);
  }
}
