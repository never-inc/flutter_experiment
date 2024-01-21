import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/app.dart';
import 'package:flutter_sample/pages/flutter_bloc/counter/counter_controller.dart'
    as bloc_counter;
import 'package:flutter_sample/pages/image_picker/tmp_cache_directory.dart';
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/impl/flutter_secure_storage_repository_3.dart'
    as fss3;
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/impl/flutter_secure_storage_repository_4.dart'
    as fss4;
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/impl/shared_preferences_repository_3.dart'
    as spr3;
import 'package:flutter_sample/repositories/local_database/shared_preferences/impl/shared_preferences_repository_4.dart'
    as spr4;
import 'package:flutter_sample/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// For GraphQLFlutter
  await initHiveForFlutter();

  /// DataSource
  final dataSource = await Future(() {
    if (kIsWeb) {
      return const FlutterSecureStorage();
    } else {
      return SharedPreferences.getInstance();
    }
  });

  /// Get it
  getIt.registerFactory<bloc_counter.CounterController>(
    bloc_counter.CounterController.new,
  );
  if (kIsWeb) {
    getIt
      ..registerLazySingleton<FlutterSecureStorage>(
        () => dataSource as FlutterSecureStorage,
      )
      ..registerLazySingleton<LocalDatabaseRepository>(
        fss4.FlutterSecureStorageRepository.new,
      );
  } else {
    getIt
      ..registerLazySingleton<SharedPreferences>(
        () => dataSource as SharedPreferences,
      )
      ..registerLazySingleton<LocalDatabaseRepository>(
        spr4.SharedPreferencesRepository.new,
      );
  }
  getIt.registerLazySingleton<http.Client>(http.Client.new);

  /// Delete Cache
  Future(() async {
    await TmpCacheDirectory.configure();
    await TmpCacheDirectory.deleteFiles();
  }).ignore();

  /// Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // 👇 Webなら FlutterSecureStorageRepository を使う
        if (kIsWeb) ...[
          flutterSecureStorageProvider
              .overrideWithValue(dataSource as FlutterSecureStorage),
          localDatabaseRepositoryProvider
              .overrideWith(fss3.FlutterSecureStorageRepository.new),
        ] else ...[
          sharedPreferencesProvider
              .overrideWithValue(dataSource as SharedPreferences),
          localDatabaseRepositoryProvider
              .overrideWith(spr3.SharedPreferencesRepository.new),
        ],
      ],
      child: const App(),
    ),
  );
}
