import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/app.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/bridge/shared_preferences_repository_3.dart'
    as spr3;
import 'package:flutter_sample/repositories/local_database/shared_preferences/bridge/shared_preferences_repository_4.dart'
    as spr4;
import 'package:flutter_sample/use_cases/counter/flutter_bloc/counter_controller.dart'
    as bloc_counter;
import 'package:flutter_sample/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  const flutterSecureStorage = FlutterSecureStorage();

  /// Get it
  getIt
    ..registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => flutterSecureStorage,
    )
    ..registerLazySingleton<LocalDatabaseRepository>(
      spr4.SharedPreferencesRepository.new,
    )
    ..registerFactory<bloc_counter.CounterController>(
      bloc_counter.CounterController.new,
    );

  /// Riverpod
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        flutterSecureStorageProvider.overrideWithValue(flutterSecureStorage),
        localDatabaseRepositoryProvider
            .overrideWith(spr3.SharedPreferencesRepository.new),
      ],
      child: const App(),
    ),
  );
}
