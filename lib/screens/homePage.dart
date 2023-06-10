import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/custom_widgets/HS_button.dart';
import 'package:honorsteine/custom_widgets/HS_texts.dart';
import 'package:honorsteine/screens/victimListPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.allVictims});

  final String title;
  final Future<List<StolpersteineData>> allVictims;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const HS_text_title(
              text : 'Welcome to Honorsteine main page.',
            ),
            const HS_text_content(
              text : '/!\\ App in construction /!\\',
            ),
            HS_button(
              text: 'View all Stolpersteine',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Victim_List(allVictims: widget.allVictims,),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
