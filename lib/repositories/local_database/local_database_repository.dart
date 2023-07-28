import 'package:flutter_sample/repositories/local_database/database_key.dart';

abstract class LocalDatabaseRepository {
  Future<void> saveInt(DatabaseKey key, int value);
  Future<int?> fetchInt(DatabaseKey key);
}
