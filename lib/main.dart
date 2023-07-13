import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/app.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/bridge/shared_preferences_repository_3.dart'
    as spr3;
import 'package:flutter_sample/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Get it
  setUp();

  /// Riverpod
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        localDatabaseRepositoryProvider
            .overrideWith(spr3.SharedPreferencesRepository.new),
      ],
      child: const App(),
    ),
  );
}
