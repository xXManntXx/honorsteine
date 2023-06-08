import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/API_fetch.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/screens/victimListPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<StolpersteineData>> allVictims;
  
  @override
  void initState() {
    super.initState();
    allVictims = fetchAPI();
  }
  
  
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
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: const Text(
                'Welcome to Honorsteine main page.',
              ),
            ),
            Text(
              '/!\\ App in construction /!\\',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Victim_List(allVictims: allVictims,),
                    ),
                  );
                },
                child: Text("Access victim list"))
          ],
        ),
      ),
    );
  }
}
