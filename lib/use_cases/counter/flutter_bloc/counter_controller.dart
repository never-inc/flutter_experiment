import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/utils.dart';

class CounterController extends Cubit<int> {
  CounterController() : super(0) {
    Future(() async {
      try {
        final value = await getIt<LocalDatabaseRepository>().fetchInt(_key);
        emit(value ?? 0);
      } on Exception catch (e) {
        addError(e);
      }
    });
  }

  static const _key = DatabaseKey.counter;

  Future<void> increment() async {
    try {
      final value = state + 1;
      await getIt<LocalDatabaseRepository>().saveInt(_key, value);
      emit(value);
    } on Exception catch (e) {
      addError(e);
    }
  }

  Future<void> decrement() async {
    try {
      final value = state - 1;
      await getIt<LocalDatabaseRepository>().saveInt(_key, value);
      emit(value);
    } on Exception catch (e) {
      addError(e);
    }
  }
}
