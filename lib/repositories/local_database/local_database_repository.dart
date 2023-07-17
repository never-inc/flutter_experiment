import 'package:flutter_sample/repositories/local_database/database_key.dart';

abstract interface class LocalDatabaseRepository {
  Future<void> saveInt(DatabaseKey key, int value);
  Future<int?> fetchInt(DatabaseKey key);
}
