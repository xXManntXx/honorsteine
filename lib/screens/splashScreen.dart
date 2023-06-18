import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/API_res/API_fetch.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_texts.dart';
import 'package:honorsteine/custom_widgets/HS_infoWindow.dart';
import 'package:honorsteine/screens/homePage.dart';
import 'package:honorsteine/screens/onboardingPage.dart';
import 'package:honorsteine/screens/stolpersteineDetailsPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  get markers => null;

  get allVictims => null;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<StolpersteineData>> allVictims;
  bool firstUse = true;
  String waitMessage = "Loading stolpersteine data . . .";
  bool dataLoaded = false;
  Set<Marker> markers = {};

  void fetchLocation(List<StolpersteineData> allVictims) async {
    for (var location in allVictims) {
      var markerIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/Marker.png');
      markers.add(Marker(
        markerId: MarkerId(location.id.toString()),
        position: LatLng(location.location[0], location.location[1]),
        infoWindow: CustomInfoWindow(
          title: location.name,
          snippet: location.address,
          photo: location.photoLink,
          buttonText: "Learn more",
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => StolpersteineDetailsPage(
                  stolpersteineData: location,
                  allVictims: widget.allVictims,
                  markers: widget.markers,
                ),
              ),
            );
          },
        ),
        icon: markerIcon,
      ));
    }
  }


  @override
  void initState() {
    super.initState();
    allVictims = fetchAPI();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if data has been loaded and navigate accordingly
    if (!dataLoaded) {
      // Wait until the future has data or an error
      allVictims.then((data) {
        setState(() {
          waitMessage = "Fetching stolpersteine locations . . .";
        });
        fetchLocation(data);
        setState(() {
          dataLoaded = true;
          if (firstUse) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OnBoardingPage(
                  allVictims: allVictims,
                  markers: markers,
                ),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: "Honorsteine",
                  allVictims: allVictims,
                  startingPageIndex: 0,
                  victim: getDefaultStolpersteineData(),
                  markers: markers,
                ),
              ),
            );
          }
        });
      }).catchError((error) {
        setState(() {
          dataLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HS_splash_screen_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionalTranslation(
                translation: Offset(0, -7.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            HS_text_content(text: waitMessage),
          ],
        ),
      ),
    );
  }
}
