import 'package:flutter/material.dart';

class Title {
  Title(this.value);
  final String value;
}

class Message {
  Message._();
  static final Title title1 = Title('');
  static Title get title2 => Title('');
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
                  final title = Message.title1;
                  debugPrint(title.hashCode.toString());
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text(
                  'Run Getter',
                ),
                onPressed: () async {
                  final title = Message.title2;
                  await Future<void>.delayed(
                    const Duration(seconds: 3),
                  ); // 待つ間にスナップショットを撮る
                  debugPrint(title.hashCode.toString());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
