import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class StreamControllerTest extends StatefulWidget {
  const StreamControllerTest({super.key});

  @override
  State<StreamControllerTest> createState() => StreamControllerTestState();
}

class StreamControllerTestState extends State<StreamControllerTest> {
  late final StreamController<DummyObject> _streamController;
  final List<StreamSubscription<DummyObject>> _disposers = [];

  @override
  void initState() {
    _streamController = StreamController<DummyObject>.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
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
                  final disposer = _streamController.stream.listen((event) {
                    debugPrint('scroll: ${event.hashCode}');
                  });
                  _disposers.add(disposer);
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
                  _streamController.sink.add(data);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Dispose',
                ),
                onPressed: () {
                  _disposers
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
