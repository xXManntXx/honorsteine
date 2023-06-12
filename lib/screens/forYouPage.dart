import 'package:flutter/material.dart';
import 'package:honorsteine/custom_widgets/HS_card.dart';

import '../API_res/stolpersteineData.dart';
import '../custom_widgets/HS_button.dart';
import '../custom_widgets/HS_texts.dart';
import 'homePage.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({Key? key, required this.allVictims}) : super(key: key);

  final Future<List<StolpersteineData>> allVictims;

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const HS_text_title(
            text: 'Welcome to Honorsteine main page.',
          ),
          const HS_text_content(
            text: '/!\\ App in construction /!\\',
          ),
          FutureBuilder<List<StolpersteineData>>(
              future: widget.allVictims,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HS_card(
                      title: "Down the road",
                      content: "Explore eindhoven's stolpersteines",
                      imageUrl: snapshot.data![1].photoLink,
                      buttonText: "Join",
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
                      victim: getDefaultStolpersteineData(),),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
