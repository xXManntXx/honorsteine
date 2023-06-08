import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/API_fetch.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<StolpersteineData>> allVictims;
  
  
  @override
  void initState() {
    super.initState();
    allVictims = fetchAPI();
    
    Timer(Duration(seconds: 4), () {
      // Navigating to the next screen after 3 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage(title: "Honorsteine", allVictims: allVictims,)),
      );
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