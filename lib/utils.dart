import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Get it
final getIt = GetIt.instance;

/// Riverpod Provider
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(),
);
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => throw UnimplementedError(),
);
final localDatabaseRepositoryProvider = Provider<LocalDatabaseRepository>(
  (_) => throw UnimplementedError(),
);
