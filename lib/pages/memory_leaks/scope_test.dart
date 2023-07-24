import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class ScopeTest extends StatelessWidget {
  const ScopeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            runtimeType.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          child: const Text(
            'Run',
          ),
          onPressed: () async {
            final data = DummyObject.create();

            await Future<void>.delayed(const Duration(seconds: 3));

            debugPrint(data.text);
          },
        ),
      ],
    );
  }
}
