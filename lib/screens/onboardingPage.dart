import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_OnboardingTip.dart';
import 'package:honorsteine/custom_widgets/HS_button.dart';
import 'package:honorsteine/custom_widgets/HS_button2.dart';
import 'package:honorsteine/custom_widgets/HS_texts.dart';
import 'package:honorsteine/screens/homePage.dart';

class OnBoardingPage extends StatefulWidget {
  final Future<List<StolpersteineData>> allVictims;
  final Set<Marker> markers;

  const OnBoardingPage({Key? key, required this.allVictims, required this.markers}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<HS_OnBoardingTip> allOnboardingTips = getAllOnBoardingTips();
  int indexOnboardingTip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100),
          allOnboardingTips[indexOnboardingTip],
          HS_text_content(
              text: "${indexOnboardingTip + 1} on ${allOnboardingTips.length}"),
          HS_button(
            text: "Next",
            onPressed: nextTip,
          ),
           HS_button2(
            text: "Back",
            onPressed: backTip,
          ),
        ],
      ),
    );
  }

  void nextTip() {
    setState(() {
      if (indexOnboardingTip + 1 >= allOnboardingTips.length) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: "Honorsteine",
                    allVictims: widget.allVictims,
                    startingPageIndex: 0,
                    victim: getDefaultStolpersteineData(),
                    markers: widget.markers,
                  )),
        );
      } else {
        indexOnboardingTip++;
      }
    });
  }
  void backTip() {
    setState(() {
      if (indexOnboardingTip == 0) {
        indexOnboardingTip = 0;
      } else {
        indexOnboardingTip--;
      }
    });
  }
}
