import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/API_fetch.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/screens/homePage.dart';
import 'package:honorsteine/screens/onboardingPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<StolpersteineData>> allVictims;
  bool firstUse = true;
  
  
  @override
  void initState() {
    super.initState();
    allVictims = fetchAPI();
    
    Timer(Duration(seconds: 4), () {

      if(firstUse) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>
              OnBoardingPage(allVictims: allVictims,)),
        );
      }
      else{
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>
              MyHomePage(title: "Honorsteine", allVictims: allVictims,)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HS_splash_screen_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FractionalTranslation(
            translation: Offset(0,-0.003*screenHeight),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}