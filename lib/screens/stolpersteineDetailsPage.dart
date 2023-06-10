import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/URL_launcher.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_button.dart';

import 'homePage.dart';

class StolpersteineDetailsPage extends StatelessWidget {
  final StolpersteineData stolpersteineData;
  final Future<List<StolpersteineData>> allVictims;

  const StolpersteineDetailsPage({required this.stolpersteineData, required this.allVictims});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Stolpersteine Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                stolpersteineData.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Gender: ${stolpersteineData.gender}",
                style: TextStyle(fontSize: 16),
              ),
              trailing: stolpersteineData.photoLink.isNotEmpty
                  ? Image.network(
                      stolpersteineData.photoLink,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(),
            ),
            SizedBox(height: 16),
            Text(
              "Reason of Persecution:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.reasonOfPersecussion),
            SizedBox(height: 16),
            Text(
              "Birth Date:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.birthDate),
            SizedBox(height: 16),
            Text(
              "Death Date:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.deathDate),
            SizedBox(height: 16),
            Text(
              "Death Place:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.deathPlace),
            SizedBox(height: 16),
            Text(
              "Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.address),
            SizedBox(height: 16),
            Text(
              "City:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(stolpersteineData.city),
            SizedBox(height: 16),
            Text(
              "Webpage links:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: stolpersteineData.url.isNotEmpty
                          ? stolpersteineData.url
                          : "No URL available.",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (stolpersteineData.url.isNotEmpty) {
                            launchURL(stolpersteineData.url);
                          }
                        },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: stolpersteineData.niodUrl.isNotEmpty
                          ? stolpersteineData.niodUrl
                          : "No niod URL available.",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (stolpersteineData.niodUrl.isNotEmpty) {
                            launchURL(stolpersteineData.niodUrl);
                          }
                        },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: stolpersteineData.mapUrl.isNotEmpty
                          ? stolpersteineData.mapUrl
                          : "No map available.",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (stolpersteineData.mapUrl.isNotEmpty) {
                            launchURL(stolpersteineData.mapUrl);
                          }
                        },
                    ),
                  ),
                ),
              ],
            ),
            HS_button(
                text: "Talk with ${stolpersteineData.name}",
                onPressed: (){
                  print(">>> Redirection to ${stolpersteineData.name} chat bot");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        title: "Honorsteine",
                        allVictims: allVictims,
                        startingPageIndex: 3,
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
