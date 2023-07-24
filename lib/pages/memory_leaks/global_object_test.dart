import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

DummyObject? dummyObject;

class GlobalObjectTest extends StatelessWidget {
  const GlobalObjectTest({super.key});

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Set Object',
                ),
                onPressed: () {
                  dummyObject = DummyObject.create();
                  debugPrint(dummyObject?.text);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Remove Object',
                ),
                onPressed: () {
                  dummyObject = null;
                  debugPrint(dummyObject?.text);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
