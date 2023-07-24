import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class StreamControllerTest extends StatefulWidget {
  const StreamControllerTest({super.key});

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<StreamControllerTest> {
  late final StreamController<DummyObject> streamController;
  final List<StreamSubscription<DummyObject>> disposers = [];

  @override
  void initState() {
    streamController = StreamController<DummyObject>.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.runtimeType.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Listen',
                ),
                onPressed: () {
                  final disposer = streamController.stream.listen((event) {
                    debugPrint('scroll: ${event.hashCode}');
                  });
                  disposers.add(disposer);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Add Data',
                ),
                onPressed: () {
                  final data = DummyObject.create();
                  streamController.sink.add(data);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Dispose',
                ),
                onPressed: () {
                  disposers
                    ..forEach((element) {
                      element.cancel();
                    })
                    ..clear();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
