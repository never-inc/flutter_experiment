import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(this.title, {super.key});

  final String title;
  @override
  State<CustomListTile> createState() => _Body();
}

class _Body extends State<CustomListTile> {
  @override
  void initState() {
    debugPrint('initState: ${widget.title}, $hashCode');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose: ${widget.title}, $hashCode');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
