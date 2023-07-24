import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class ScrollControllerTest extends StatefulWidget {
  const ScrollControllerTest({super.key});

  @override
  State<ScrollControllerTest> createState() => ScrollControllerTestState();
}

class ScrollControllerTestState extends State<ScrollControllerTest> {
  late final ScrollController _scrollController;
  final List<VoidCallback> _listeners = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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

                  _scrollController.addListener(listener);
                  _listeners.add(listener);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Remove Listener',
                ),
                onPressed: () {
                  _listeners
                    ..forEach(_scrollController.removeListener)
                    ..clear();
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
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
