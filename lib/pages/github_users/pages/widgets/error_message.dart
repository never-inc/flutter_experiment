import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    required this.message,
    required this.onTapRetry,
    super.key,
  });

  final String message;
  final VoidCallback onTapRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'エラーが発生しました\n$message',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FilledButton(
              onPressed: onTapRetry,
              child: const Text('再試行'),
            ),
          ),
        ],
      ),
    );
  }
}
