import 'package:flutter/material.dart';

class HS_text_title extends StatelessWidget {
  final String text;

  const HS_text_title({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class HS_text_content extends StatelessWidget {
  final String text;

  const HS_text_content({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
