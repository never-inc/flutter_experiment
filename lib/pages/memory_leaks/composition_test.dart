import 'package:flutter/material.dart';

class CompositionData {
  CompositionData(this.text);
  final String text;
}

class CompositionTest extends StatelessWidget {
  const CompositionTest(this.data, {super.key});

  final CompositionData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Center(
        child: Text(
          data.hashCode.toString(),
        ),
      ),
    );
  }
}
