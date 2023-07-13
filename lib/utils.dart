import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/bridge/shared_preferences_repository_3.dart'
    as riverpod;
import 'package:flutter_sample/repositories/local_database/shared_preferences/bridge/shared_preferences_repository_4.dart'
    as get_it;
import 'package:flutter_sample/use_cases/counter/flutter_bloc/counter_controller.dart'
    as flutter_bloc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Get it
final getIt = GetIt.instance;
void setUp() {
  getIt
    ..registerSingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<LocalDatabaseRepository>(
      get_it.SharedPreferencesRepository.new,
    )
    ..registerFactory<flutter_bloc.CounterController>(
      flutter_bloc.CounterController.new,
    );
}

/// Provider
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError(),
);
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);
final localDatabaseRepositoryProvider = Provider<LocalDatabaseRepository>(
  riverpod.SharedPreferencesRepository.new,
);
