import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

final dummyObjectProvider = Provider<DummyObject>((ref) {
  ref.onDispose(() {
    debugPrint('dispose');
  });
  return DummyObject.create();
});

final dummyObjectAutoDisposeProvider = Provider.autoDispose<DummyObject>((ref) {
  ref.onDispose(() {
    debugPrint('dispose');
  });
  return DummyObject.create();
});

class RiverpodTest extends ConsumerWidget {
  const RiverpodTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            runtimeType.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Run',
                ),
                onPressed: () {
                  final value = ref.read(dummyObjectProvider);
                  debugPrint('${value.hashCode}');
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Run AutoDispose',
                ),
                onPressed: () async {
                  final value = ref.read(dummyObjectAutoDisposeProvider);
                  await Future<void>.delayed(const Duration(seconds: 3));
                  debugPrint('${value.hashCode}');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
