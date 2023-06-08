import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_OnboardingTip.dart';
import 'package:honorsteine/custom_widgets/HS_button.dart';

class OnBoardingPage extends StatefulWidget {
  final Future<List<StolpersteineData>> allVictims;

  const OnBoardingPage({Key? key, required this.allVictims}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100),
          HS_OnBoardingTip(
            imageUrl: 'assets/HS_onboarding_1.png',
            title: 'Choose a route',
            content:
                'Travel through the city, visit stolpersteines and experience the city',
          ),
          HS_button(
            text: "Next",
            onPressed: nextTip,
          ),
        ],
      ),
    );
  }

  void nextTip() {
    print(">>> Next tip");
  }
}
