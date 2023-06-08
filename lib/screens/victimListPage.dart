import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/screens/stolpersteineDetailsPage.dart';
import 'dart:async';

class Victim_List extends StatefulWidget {
  const Victim_List({Key? key, required this.allVictims}) : super(key: key);

  final Future<List<StolpersteineData>> allVictims;

  @override
  State<Victim_List> createState() => _Victim_ListState();
}

class _Victim_ListState extends State<Victim_List> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<StolpersteineData>>(
              future: widget.allVictims,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('>>> Snasphot has data !');
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(
                                "Adress : ${snapshot.data![index].city}, ${snapshot.data![index].address} "),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StolpersteineDetailsPage(
                                          stolpersteineData: snapshot.data![index]),
                                ),
                              );
                            },
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  print('>>> Error : ${snapshot.error}');
                  return Text('error : ${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
