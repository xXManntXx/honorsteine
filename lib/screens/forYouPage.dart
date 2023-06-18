import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/custom_widgets/HS_button2.dart';
import 'package:honorsteine/custom_widgets/HS_card.dart';
import 'package:honorsteine/screens/stolpersteineDetailsPage.dart';

import '../API_res/stolpersteineData.dart';
import '../custom_widgets/HS_button.dart';
import '../custom_widgets/HS_texts.dart';
import 'homePage.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({Key? key, required this.allVictims, required this.markers})
      : super(key: key);

  final Future<List<StolpersteineData>> allVictims;
  final Set<Marker> markers;

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  late StolpersteineData randomLocalVictim;
  late List<StolpersteineData> filteredData;

  void findRandomNeighbour(){
    Random random = Random();
    int randomIndex = random.nextInt(filteredData.length);
    randomLocalVictim = filteredData[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: HS_text_title(
                text: 'Your home page',
              ),
            ),
            FutureBuilder<List<StolpersteineData>>(
                future: widget.allVictims,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HS_card(
                        title: "Down the road",
                        content: "Explore eindhoven's stolpersteines",
                        imageUrl: snapshot.data![1].photoLink,
                        buttonText: "Join walk",
                        onPressed: () {
                          print(">>> HS_Card button pushed");
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            HS_button(
              text: 'View all Stolpersteine',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      title: "All stolpersteine",
                      allVictims: widget.allVictims,
                      startingPageIndex: 2,
                      victim: getDefaultStolpersteineData(),
                      markers: widget.markers,
                    ),
                  ),
                );
              },
            ),
            const HS_text_title(text: "They were our neighbour :"),
            FutureBuilder<List<StolpersteineData>>(
                future: widget.allVictims,
                builder: (context, snapshot) {
                  String searchText =
                      "eindhoven"; //todo change with user location city
                  if (snapshot.hasData) {
                    filteredData = snapshot.data!
                        .where((victim) =>
                            victim.city.toLowerCase().contains(searchText))
                        .toList();
                    if (filteredData.isNotEmpty) {
                      findRandomNeighbour();
                      return HS_card(
                          title: randomLocalVictim.name,
                          content:
                              "Last lived freely at : ${randomLocalVictim.address}",
                          imageUrl: randomLocalVictim.photoLink,
                          buttonText: "Learn more",
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StolpersteineDetailsPage(
                                        stolpersteineData: randomLocalVictim,
                                        allVictims: widget.allVictims,
                                        markers: widget.markers,
                                      )),
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            HS_button2(
              text: 'Find another one',
              padding: 2.0,
              onPressed: (){
                setState(() {
                  findRandomNeighbour();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
