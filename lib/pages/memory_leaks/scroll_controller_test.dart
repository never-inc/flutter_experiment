import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class ScrollControllerTest extends StatefulWidget {
  const ScrollControllerTest({super.key});

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<ScrollControllerTest> {
  late final ScrollController scrollController;

  final List<VoidCallback> listeners = [];

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
                  'Set Listener',
                ),
                onPressed: () {
                  final obj = DummyObject.create();
                  void listener() {
                    debugPrint('scroll: ${obj.hashCode}');
                  }

                  scrollController.addListener(listener);
                  listeners.add(listener);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Remove Listener',
                ),
                onPressed: () {
                  listeners
                    ..forEach(scrollController.removeListener)
                    ..clear();
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Text('$index');
            },
            itemCount: 100,
          ),
        ),
      ],
    );
  }
}
