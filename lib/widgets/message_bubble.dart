import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../API_res/stolpersteineData.dart';
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.content,
    required this.victim,
    required this.isUserMessage,
    super.key,
  });

  final StolpersteineData victim;
  final String content;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    BoxDecoration boxDecoration = BoxDecoration(
      color: isUserMessage
          ? themeData.colorScheme.primary.withOpacity(0.7)
          : themeData.colorScheme.secondary.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    );

    // Add stroke to the BoxDecoration if the color is false, uncomment this and change opacity to 0
  /*  if (!isUserMessage) {
      boxDecoration = boxDecoration.copyWith(
        border: Border.all(
          color: Colors.black, // Customize the stroke color here
          width: 2.0, // Customize the stroke width here
        ),
      );
    }*/

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  isUserMessage ? 'You' : victim.name.split(" ")[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            MarkdownWidget(
              data: content,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
