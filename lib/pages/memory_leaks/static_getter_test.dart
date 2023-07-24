import 'package:flutter/material.dart';

class Title {
  Title(this.value);
  final String value;
}

class Message {
  Message._();
  static Title title1 = Title('タイトル1');
  static Title get title2 => Title('タイトル2');
}

class StaticGetterTest extends StatelessWidget {
  const StaticGetterTest({super.key});

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
                  'Run Static',
                ),
                onPressed: () {
                  debugPrint(Message.title1.value);
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Run Getter',
                ),
                onPressed: () {
                  debugPrint(Message.title2.value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
