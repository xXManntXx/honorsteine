import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/API_res/URL_launcher.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_card.dart';
import 'package:honorsteine/custom_widgets/HS_texts.dart';

import 'homePage.dart';

class StolpersteineDetailsPage extends StatelessWidget {
  final StolpersteineData stolpersteineData;
  final Future<List<StolpersteineData>> allVictims;
  final Set<Marker> markers;

  const StolpersteineDetailsPage(
      {required this.stolpersteineData, required this.allVictims, required this.markers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stolpersteine Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HS_card(
              title: stolpersteineData.name,
              content:
                  "${stolpersteineData.reasonOfPersecussion}\n${stolpersteineData.birthDate} - ${stolpersteineData.deathDate}",
              imageUrl: stolpersteineData.photoLink,
              buttonText: stolpersteineData.gender == "male"
                  ? "Talk to his chatbot"
                  : "Talk to her chatbot",
              onPressed: () {
                print(">>> Redirection to ${stolpersteineData.name} chat bot");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      title: "Honorsteine",
                      allVictims: allVictims,
                      startingPageIndex: 3,
                      victim: stolpersteineData,
                      markers: markers,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            HS_text_title(text: "Location"),
            HS_text_content(
                text:
                    "${stolpersteineData.gender == "male" ? "He" : "She"} last lived freely in the city of ${stolpersteineData.city}.\n"
                    "You can commemorate ${stolpersteineData.gender == "male" ? "him" : "her"} at ${stolpersteineData.address} where lies ${stolpersteineData.gender == "male" ? "his" : "her"} stolpersteine.\n"
                    "${stolpersteineData.deathPlace == "nvt" ? "${stolpersteineData.gender == "male" ? "He" : "She"} survived the war." : "${stolpersteineData.gender == "male" ? "He" : "She"} died at ${stolpersteineData.deathPlace}"}"),
            const SizedBox(height: 16),
            if (stolpersteineData.url != "null" ||
                stolpersteineData.niodUrl != "null" ||
                stolpersteineData.mapUrl != "null")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HS_text_title(
                      text:
                          "Learn more about ${stolpersteineData.gender == "male" ? "him" : "her"} here :"),
                  Padding(
                    padding: stolpersteineData.url != "null"
                        ? const EdgeInsets.all(8.0)
                        : const EdgeInsets.all(0.0),
                    child: RichText(
                      text: TextSpan(
                        text: stolpersteineData.url != "null"
                            ? stolpersteineData.url
                            : "",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (stolpersteineData.url != "null") {
                              launchURL(stolpersteineData.url);
                            }
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: stolpersteineData.niodUrl != "null"
                        ? const EdgeInsets.all(8.0)
                        : const EdgeInsets.all(0.0),
                    child: RichText(
                      text: TextSpan(
                        text: stolpersteineData.niodUrl != "null"
                            ? stolpersteineData.niodUrl
                            : "",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (stolpersteineData.niodUrl != "null") {
                              launchURL(stolpersteineData.niodUrl);
                            }
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: stolpersteineData.mapUrl != "null"
                        ? const EdgeInsets.all(8.0)
                        : const EdgeInsets.all(0.0),
                    child: RichText(
                      text: TextSpan(
                        text: stolpersteineData.mapUrl != "null"
                            ? stolpersteineData.mapUrl
                            : "",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (stolpersteineData.mapUrl != "null") {
                              launchURL(stolpersteineData.mapUrl);
                            }
                          },
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
