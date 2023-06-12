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
        const SizedBox(height: 10.0),
        HS_text_title(text: title),
        const SizedBox(height: 10.0),
        HS_text_content(text: content),
      ],
    );
  }
}

List<HS_OnBoardingTip> getAllOnBoardingTips() {
  return [
    const HS_OnBoardingTip(
      imageUrl: 'assets/HS_onboarding_1.png',
      title: 'Choose a route',
      content:
          'Travel through the city, visit stolpersteines and experience the city',
    ),
    const HS_OnBoardingTip(
      imageUrl: 'assets/HS_onboarding_2.png',
      title: 'Find out whats nearby',
      content:
          'Granting the Honorsteine app access to your location will allow it to search for stones nearby',
    ),
    const HS_OnBoardingTip(
      imageUrl: 'assets/HS_onboarding_3.png',
      title: 'Create or join routes',
      content:
          'Meet people, explore destinations, find intresting stories and things to watch.',
    ),
    const HS_OnBoardingTip(
      imageUrl: 'assets/HS_onboarding_4.png',
      title: 'Explore Stolpersteine',
      content: "Let's get started !",
    ),
  ];
}
