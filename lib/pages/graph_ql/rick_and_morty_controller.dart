import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/api/rick_and_morty_repository.dart';

final rickAndMortyControllerProvider =
    AsyncNotifierProvider.autoDispose<RickAndMortyController, List<String>>(
  RickAndMortyController.new,
);

final class RickAndMortyController
    extends AutoDisposeAsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() async {
    final value =
        await ref.watch(rickAndMortyRepositoryProvider).fetchNameRick();
    return value;
  }
}
