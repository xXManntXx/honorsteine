import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../API_res/URL_launcher.dart';

class HS_text_title extends StatelessWidget {
  final String text;

  const HS_text_title({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
      padding: const EdgeInsets.all(12.0),
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

class HS_hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final double padding;

  const HS_hyperlink({Key? key, required this.url, required this.text, this.padding = 12.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 20,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
                launchURL(url);
            },
        ),
      ),
    );
  }
}

