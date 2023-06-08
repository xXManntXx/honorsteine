import 'package:flutter/material.dart';
import 'package:honorsteine/custom_widgets/HS_texts.dart';

class HS_OnBoardingTip extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;

  const HS_OnBoardingTip({
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        HS_text_title(text: title),
        SizedBox(height: 10.0),
        HS_text_content(text: content),
      ],
    );
  }
}
